//
//  GeneralPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation
import NIO

public final class GeneralPacketMojang : GeneralPacket {
    public static func == (lhs: GeneralPacketMojang, rhs: GeneralPacketMojang) -> Bool {
        return lhs.length == rhs.length && lhs.packet_id == rhs.packet_id && lhs.data.elementsEqual(rhs.data)
    }
    
    public static let segment_bits:UInt8 = 0x7F
    public static let continue_bit:UInt8 = 0x80
    
    public let length:UInt8
    public let packet_id:UInt8
    public let data:ArraySlice<UInt8>
    
    public private(set) var reading_index:Int = 0
    
    public init(bytes: [UInt8]) {
        length = bytes[0]
        packet_id = bytes[1]
        data = bytes[2..<bytes.count]
        reading_index = 2
        print("GeneralPacketMojang;data=" + data.description)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(length)
        hasher.combine(packet_id)
        hasher.combine(data)
    }
    
    /// > Tip: Minecraft's VarInts are identical to [LEB128](https://en.wikipedia.org/wiki/LEB128) with the slight change of throwing a exception if it goes over a set amount of bytes.
    ///
    /// Minecraft's VarInts are not encoded using Protocol Buffers; it's just similar. If you try to use Protocol Buffers Varints with Minecraft's VarInts, you'll get incorrect results in some cases. The major differences:
    /// - Minecraft's VarInts are all signed, but do not use the ZigZag encoding. Protocol buffers have 3 types of Varints: `uint32` (normal encoding, unsigned), `sint32` (ZigZag encoding, signed), and `int32` (normal encoding, signed). Minecraft's are the `int32` variety. Because Minecraft uses the normal encoding instead of ZigZag encoding, negative values always use the maximum number of bytes.
    /// - Minecraft's VarInts are never longer than 5 bytes and its VarLongs will never be longer than 10 bytes, while Protocol Buffer Varints will always use 10 bytes when encoding negative numbers, even if it's an `int32`.
    public func read_var_int() throws -> VariableInteger {
        var value:Int = 0
        var position:Int = 0
        var current_byte:UInt8 = 0
        while true {
            current_byte = data[reading_index]
            reading_index += 1
            value |= Int(current_byte & GeneralPacketMojang.segment_bits) << position
            
            if ((current_byte & GeneralPacketMojang.continue_bit) == 0) {
                break
            }
            position += 7
            if position >= 32 {
                throw GeneralPacketError.varint_is_too_big
            }
        }
        return VariableInteger(value: value)
    }
    
    private func from_bytes<T>(bytes: Int) throws -> T {
        let slice:ArraySlice<UInt8> = data[reading_index..<reading_index + bytes]
        guard slice.count == MemoryLayout<T>.size else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bruh")) // TODO: fix
        }
        let value:T = slice.withUnsafeBytes { pointer in
            return pointer.load(as: T.self)
        }
        reading_index += bytes
        return value
    }
    private func to_bytes<T>(value: T, withCapacity capacity: Int) -> [UInt8] {
        var mutable_value:T = value
        let bytes:[UInt8] = withUnsafePointer(to: &mutable_value) { pointer1 in
            return pointer1.withMemoryRebound(to: UInt8.self, capacity: capacity) { pointer2 in
                return Array(UnsafeBufferPointer(start: pointer2, count: capacity))
            }
        }
        return bytes
    }
    
    public func read_byte() throws -> UInt8 {
        let byte:UInt8 = data[reading_index]
        reading_index += 1
        return byte
    }
    public func read_short() throws -> Int {
        return try from_bytes(bytes: 2)
    }
    public func read_int() throws -> Int {
        return try from_bytes(bytes: 4)
    }
    public func read_long() throws -> Int {
        return try from_bytes(bytes: 8)
    }
    
    private func read_floating_point_little_endian<T: FloatingPoint>(bytes: Int) throws -> T {
        let slice:ArraySlice<UInt8> = data[reading_index..<reading_index + bytes]
        let value:T = slice.withUnsafeBytes { pointer in
            return pointer.load(fromByteOffset: 0, as: T.self)
        }
        reading_index += bytes
        return value
    }
    public func read_float() throws -> Float {
        return try from_bytes(bytes: 4)
    }
    public func read_double() throws -> Double {
        return try from_bytes(bytes: 8)
    }
    
    public func read_string(size: Int) -> String {
        let string:String = String((0..<size).map({ i in data[reading_index + i].char }))
        reading_index += size
        return string
    }
    public func read_string() throws -> String {
        let size:Int = try read_var_int().value
        return read_string(size: size)
    }
    
    public func read_bool() throws -> Bool {
        let byte:UInt8 = data[reading_index]
        reading_index += 1
        return byte == 1
    }
    
    public func read_angle() throws -> AngleMojang {
        let byte:UInt8 = data[reading_index]
        reading_index += 1
        return AngleMojang(value: Int(byte))
    }
    
    public func read_enum<T: PacketEncodableMojang & RawRepresentable<Int>>() throws -> T {
        let integer:Int = try read_var_int().value
        guard let value:T = T.init(rawValue: integer) else {
            throw ServerPacketMojangErrors.VarIntEnum.doesnt_exist(type: T.self, id: integer)
        }
        return value
    }
    
    public func read_remaining_byte_array() throws -> [UInt8] {
        return try read_byte_array(bytes: data.count - reading_index)
    }
    public func read_byte_array(bytes: VariableInteger) throws -> [UInt8] {
        return try read_byte_array(bytes: bytes.value)
    }
    public func read_byte_array(bytes: Int) throws -> [UInt8] {
        let slice:ArraySlice<UInt8> = data[reading_index..<reading_index + bytes]
        reading_index += bytes
        return [UInt8](slice)
    }
    
    public func read_string_array(count: Int) throws -> [String] {
        return try (0..<count).map({ _ in
            let size:Int = try read_var_int().value
            return read_string(size: size)
        })
    }
    
    public func read_map<T>(count: VariableInteger, transform: () throws -> T) rethrows -> [T] {
        return try read_map(count: count.value, transform: transform)
    }
    public func read_map<T>(count: Int, transform: () throws -> T) rethrows -> [T] {
        return try (0..<count).map({ _ in try transform() })
    }
    
    public func read_packet_decodable_array<T: PacketDecodableMojang>(count: VariableInteger) throws -> [T] {
        return try read_packet_decodable_array(count: count.value)
    }
    public func read_packet_decodable_array<T: PacketDecodableMojang>(count: Int) throws -> [T] {
        return try (0..<count).map({ _ in try read_packet_decodable() })
    }
    public func read_packet_decodable<T: PacketDecodableMojang>() throws -> T {
        let value:T = try T.decode(from: self)
        reading_index += try value.packet_bytes().count
        return value
    }
    
    public func read_identifier() throws -> Namespace {
        let string:String = try read_string()
        let values:[Substring] = string.split(separator: ".")
        guard values.count == 2 else {
            throw GeneralPacketError.namespace_value_length_not_equal
        }
        return Namespace(identifier: values[0], value: values[1])
    }
    
    public func read_uuid() throws -> UUID {
        let string:String = read_string(size: 16)
        guard let uuid:UUID = UUID(string) else {
            throw GeneralPacketError.invalid_uuid(string: string)
        }
        return uuid
    }
    
    public func read_data(bytes: Int) throws -> Data {
        let array:[UInt8] = try read_byte_array(bytes: bytes)
        return Data(array)
    }
    
    public func read_json<T: Decodable>() throws -> T {
        let size:Int = try read_var_int().value
        let bytes:ArraySlice<UInt8> = data[reading_index..<reading_index + size]
        let buffer:ByteBuffer = ByteBuffer(bytes: bytes)
        let json:T = try JSONDecoder().decode(T.self, from: buffer)
        reading_index += size
        return json
    }
}
