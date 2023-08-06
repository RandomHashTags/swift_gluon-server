//
//  GeneralPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

public struct GeneralPacketMojang : GeneralPacket {
    public static let segment_bits:UInt8 = 0x7F
    public static let continue_bit:UInt8 = 0x80
    
    public let length:UInt8
    public let packet_id:UInt8
    public let data:[UInt8]
    
    public private(set) var reading:Bool = false
    public private(set) var reading_index:Int = 0
    
    public init(bytes: [UInt8]) {
        length = bytes[0]
        packet_id = bytes[1]
        data = [UInt8](bytes[2..<bytes.count])
        print("GeneralPacketMojang;data=" + data.description)
    }
    
    /// > Tip: Minecraft's VarInts are identical to [LEB128](https://en.wikipedia.org/wiki/LEB128) with the slight change of throwing a exception if it goes over a set amount of bytes.
    ///
    /// Minecraft's VarInts are not encoded using Protocol Buffers; it's just similar. If you try to use Protocol Buffers Varints with Minecraft's VarInts, you'll get incorrect results in some cases. The major differences:
    /// - Minecraft's VarInts are all signed, but do not use the ZigZag encoding. Protocol buffers have 3 types of Varints: `uint32` (normal encoding, unsigned), `sint32` (ZigZag encoding, signed), and `int32` (normal encoding, signed). Minecraft's are the `int32` variety. Because Minecraft uses the normal encoding instead of ZigZag encoding, negative values always use the maximum number of bytes.
    /// - Minecraft's VarInts are never longer than 5 bytes and its VarLongs will never be longer than 10 bytes, while Protocol Buffer Varints will always use 10 bytes when encoding negative numbers, even if it's an `int32`.
    public mutating func read_var_int() throws -> Int {
        var value:Int = 0
        var position:Int = 0
        var current_byte:UInt8 = 0
        while true {
            current_byte = data[reading_index]
            reading_index += 1
            value |= Int( (current_byte & GeneralPacketMojang.segment_bits) << position )
            
            if ((current_byte & GeneralPacketMojang.continue_bit) == 0) {
                break
            }
            position += 7
            if position >= 32 {
                throw GeneralPacketError.varint_is_too_big
            }
        }
        print("GeneralPacketMojang;read_var_int;returned \(value)")
        return value
    }
    
    public mutating func read_string() throws -> String {
        let size:Int = try read_var_int()
        var string:String = ""
        for i in 0..<size {
            string.append(data[reading_index + i].char)
        }
        reading_index += size
        return string
    }
}
