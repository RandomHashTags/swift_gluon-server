//
//  GeneralPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation
import NIO

fileprivate extension Array where Element == UInt8 {
    func read_var_int(byteOffset: Int = 0) throws -> (result: VariableIntegerJava, read_bytes: Int) {
        var value:Int32 = 0
        var position:Int = 0
        var current_byte:UInt8 = 0
        var reading_index:Int = byteOffset
        while true {
            current_byte = self[reading_index]
            reading_index += 1
            value |= Int32(current_byte & GeneralPacketMojang.segment_bits) << position
            
            if current_byte & GeneralPacketMojang.continue_bit == 0 {
                break
            }
            position += 7
            if position >= 32 {
                throw GeneralPacketError.varint_is_too_big
            }
        }
        return (VariableIntegerJava(value: value), reading_index - byteOffset)
    }
}

public final class GeneralPacketMojang : GeneralPacket {
    public static func == (lhs: GeneralPacketMojang, rhs: GeneralPacketMojang) -> Bool {
        return lhs.length == rhs.length && lhs.packetID == rhs.packetID && lhs.data.elementsEqual(rhs.data)
    }
    
    public static let segment_bits:UInt8 = 0x7F
    public static let continue_bit:UInt8 = 0x80
    
    public let length:VariableIntegerJava
    public let packetID:VariableIntegerJava
    public let data:ArraySlice<UInt8>
    
    public private(set) var reading_index:Int = 0
    
    public init(bytes: [UInt8]) throws {
        let (length, length_read_bytes):(VariableIntegerJava, Int) = try bytes.readVarInt()
        self.length = length
        let (packetID, packet_read_bytes):(VariableIntegerJava, Int) = try bytes.read_var_int(byteOffset: length_read_bytes)
        self.packetID = packetID
        let offset:Int = length_read_bytes + packet_read_bytes
        data = bytes[offset..<bytes.count]
        reading_index = offset
        //print("GeneralPacketMojang;length=\(length);packetID=\(packetID);offset=\(offset);data=" + data.description + ";bytes=" + bytes.description)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(length)
        hasher.combine(packetID)
        hasher.combine(data)
    }
    
    /// > Tip: Minecraft's VarInts are identical to [LEB128](https://en.wikipedia.org/wiki/LEB128) with the slight change of throwing a exception if it goes over a set amount of bytes.
    ///
    /// Minecraft's VarInts are not encoded using Protocol Buffers; it's just similar. If you try to use Protocol Buffers Varints with Minecraft's VarInts, you'll get incorrect results in some cases. The major differences:
    /// - Minecraft's VarInts are all signed, but do not use the ZigZag encoding. Protocol buffers have 3 types of Varints: `uint32` (normal encoding, unsigned), `sint32` (ZigZag encoding, signed), and `int32` (normal encoding, signed). Minecraft's are the `int32` variety. Because Minecraft uses the normal encoding instead of ZigZag encoding, negative values always use the maximum number of bytes.
    /// - Minecraft's VarInts are never longer than 5 bytes and its VarLongs will never be longer than 10 bytes, while Protocol Buffer Varints will always use 10 bytes when encoding negative numbers, even if it's an `int32`.
    public func readVarInt() throws -> VariableIntegerJava {
        var value:Int32 = 0
        var position:Int = 0
        var current_byte:UInt8 = 0
        while true {
            current_byte = data[reading_index]
            reading_index += 1
            value |= Int32(current_byte & GeneralPacketMojang.segment_bits) << position
            
            if current_byte & GeneralPacketMojang.continue_bit == 0 {
                break
            }
            position += 7
            if position >= 32 {
                throw GeneralPacketError.varint_is_too_big
            }
        }
        return VariableIntegerJava(value: value)
    }
    
    public func readVarLong() throws -> VariableLongJava {
        var value:Int64 = 0
        var position:Int = 0
        var current_byte:UInt8 = 0
        while true {
            current_byte = data[reading_index]
            reading_index += 1
            value |= Int64(current_byte & GeneralPacketMojang.segment_bits) << position
            
            if current_byte & GeneralPacketMojang.continue_bit == 0 {
                break
            }
            position += 7
            if position >= 32 {
                throw GeneralPacketError.varlong_is_too_big
            }
        }
        return VariableLongJava(value: value)
    }
    
    private func from_bytes_integer<T : FixedWidthInteger>(bytes: Int) throws -> T {
        let slice:[UInt8] = [UInt8](data[reading_index..<reading_index + bytes])
        guard slice.count == MemoryLayout<T>.size else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bruh;slice.count=\(slice.count);memorylayout.size=\(MemoryLayout<T>.size)")) // TODO: fix
        }
        let value:T = slice.withUnsafeBytes { pointer in
            return pointer.load(as: T.self)
        }
        reading_index += bytes
        return value.bigEndian
    }
    private func from_bytes<T>(bytes: Int) throws -> T {
        let slice:[UInt8] = [UInt8](data[reading_index..<reading_index + bytes])
        guard slice.count == MemoryLayout<T>.size else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bruh;slice.count=\(slice.count);memorylayout.size=\(MemoryLayout<T>.size)")) // TODO: fix
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
    
    public func readByte() throws -> Int8 {
        return try from_bytes_integer(bytes: 1)
    }
    public func readUnsignedByte() throws -> UInt8 {
        return try from_bytes_integer(bytes: 1)
    }
    
    public func readShort() throws -> Int16 {
        return try from_bytes_integer(bytes: 2)
    }
    public func readUnsignedShort() throws -> UInt16 {
        return try from_bytes_integer(bytes: 2)
    }
    
    public func readInt() throws -> Int32 {
        return try from_bytes_integer(bytes: 4)
    }
    public func readLong() throws -> Int64 {
        return try from_bytes_integer(bytes: 8)
    }
    
    public func readUnsignedLong() throws -> UInt64 {
        return try from_bytes_integer(bytes: 8)
    }
    
    private func read_floating_point_little_endian<T: FloatingPoint>(bytes: Int) throws -> T {
        let slice:ArraySlice<UInt8> = data[reading_index..<reading_index + bytes]
        let value:T = slice.withUnsafeBytes { pointer in
            return pointer.load(fromByteOffset: 0, as: T.self)
        }
        reading_index += bytes
        return value
    }
    public func readFloat() throws -> Float {
        return try from_bytes(bytes: 4)
    }
    public func readDouble() throws -> Double {
        return try from_bytes(bytes: 8)
    }
    
    public func read_string(size: Int) -> String {
        let string:String = String((0..<size).map({ i in data[reading_index + i].char }))
        reading_index += size
        return string
    }
    public func readString() throws -> String {
        let size:Int = try readVarInt().value_int
        return read_string(size: size)
    }
    
    public func readBool() throws -> Bool {
        let byte:UInt8 = data[reading_index]
        reading_index += 1
        return byte == 1
    }
    
    public func readAngle() throws -> AngleMojang {
        let byte:UInt8 = data[reading_index]
        reading_index += 1
        return AngleMojang(value: Int(byte))
    }
    
    public func read_enum<T: PacketEncodableMojangJava & RawRepresentable<Int>>() throws -> T {
        let integer:Int = try readVarInt().value_int
        guard let value:T = T.init(rawValue: integer) else {
            throw ServerPacketMojangErrors.VarIntEnum.doesnt_exist(type: T.self, id: integer)
        }
        return value
    }
    
    public func readRemainingByteArray() throws -> [UInt8] {
        return try read_byte_array(bytes: data.count - reading_index)
    }
    public func readRemainingOptionalByteArray() throws -> [UInt8]? {
        let bytes:Int = data.count - reading_index
        guard bytes > 0 else { return nil }
        return try read_byte_array(bytes: bytes)
    }
    public func read_byte_array(bytes: VariableIntegerJava) throws -> [UInt8] {
        return try read_byte_array(bytes: bytes.value_int)
    }
    public func read_byte_array(bytes: Int) throws -> [UInt8] {
        let slice:ArraySlice<UInt8> = data[reading_index..<reading_index + bytes]
        reading_index += bytes
        return [UInt8](slice)
    }
    
    public func read_string_array(count: VariableIntegerJava) throws -> [String] {
        return try read_string_array(count: count.value_int)
    }
    public func read_string_array(count: Int) throws -> [String] {
        return try (0..<count).map({ _ in
            let size:Int = try readVarInt().value_int
            return read_string(size: size)
        })
    }
    
    public func read_map<T>(count: VariableIntegerJava, transform: () throws -> T) rethrows -> [T] {
        return try read_map(count: count.value_int, transform: transform)
    }
    public func read_map<T>(count: Int, transform: () throws -> T) rethrows -> [T] {
        return try (0..<count).map({ _ in try transform() })
    }
    
    public func read_packet_decodable_array<T: PacketDecodableMojangJava>(count: VariableIntegerJava) throws -> [T] {
        return try read_packet_decodable_array(count: count.value_int)
    }
    public func read_packet_decodable_array<T: PacketDecodableMojangJava>(count: Int) throws -> [T] {
        return try (0..<count).map({ _ in try read_packet_decodable() })
    }
    public func read_packet_decodable<T: PacketDecodableMojangJava>() throws -> T {
        let value:T = try T.decode(from: self)
        reading_index += try value.packet_bytes().count
        return value
    }
    
    public func readIdentifier() throws -> Namespace {
        let string:String = try readString()
        let values:[Substring] = string.split(separator: ".")
        guard values.count == 2 else {
            throw GeneralPacketError.namespace_value_length_not_equal
        }
        return Namespace(identifier: values[0], value: values[1])
    }
    
    public func readUUID() throws -> UUID {
        let left:UInt64 = try readUnsignedLong()
        let right:UInt64 = try readUnsignedLong()
        let left_array:[UInt8] = withUnsafeBytes(of: left.bigEndian, Array.init)
        let right_array:[UInt8] = withUnsafeBytes(of: right.bigEndian, Array.init)
        let test:uuid_t = (
            left_array[0], left_array[1], left_array[2], left_array[3], left_array[4], left_array[5], left_array[6], left_array[7],
            right_array[0], right_array[1], right_array[2], right_array[3], right_array[4], right_array[5], right_array[6], right_array[7]
        )
        return UUID(uuid: test)
    }
    
    public func read_data(bytes: Int) throws -> Data {
        let array:[UInt8] = try read_byte_array(bytes: bytes)
        return Data(array)
    }
    
    public func read_json<T: Decodable>() throws -> T {
        let size:Int = try readVarInt().value_int
        let bytes:ArraySlice<UInt8> = data[reading_index..<reading_index + size]
        let buffer:ByteBuffer = ByteBuffer(bytes: bytes)
        let json:T = try JSONDecoder().decode(T.self, from: buffer)
        reading_index += size
        return json
    }
}
