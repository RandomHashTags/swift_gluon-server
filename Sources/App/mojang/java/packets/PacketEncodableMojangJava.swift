//
//  PacketEncodableMojangJava.swift
//
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketEncodableMojangJava : PacketEncodable {
}
public extension PacketEncodableMojangJava where Self : RawRepresentable, RawValue : PacketEncodableMojangJava {
    func packet_bytes() throws -> [UInt8] {
        return try rawValue.packet_bytes()
    }
}

extension FixedWidthInteger {
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = []
        var value:Self = self
        let segment_bits:Self = Self(GeneralPacketMojang.segment_bits)
        while true {
            if (value & ~segment_bits) == 0 {
                array.append(UInt8(value))
                break
            }
            array.append(UInt8( (value & segment_bits) | Self(GeneralPacketMojang.continue_bit)) )
            value >>= 7
        }
        return array
    }
}

extension Int : PacketEncodableMojangJava {}
extension Int8 : PacketEncodableMojangJava {}
extension Int16 : PacketEncodableMojangJava, PacketDecodableMojangJava {
    public static func decode(from packet: GeneralPacketMojang) throws -> Int16 {
        return try packet.read_short()
    }
}
extension Int32 : PacketEncodableMojangJava {}
extension Int64 : PacketEncodableMojangJava {}
extension UInt8 : PacketEncodableMojangJava {}
extension UInt16 : PacketEncodableMojangJava {}
extension UInt32 : PacketEncodableMojangJava {}
extension UInt64 : PacketEncodableMojangJava {}

extension Double : PacketEncodableMojangJava {
    // TODO: support
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = []
        return array
    }
}
extension Float : PacketEncodableMojangJava {
    // TODO: support
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = []
        return array
    }
}

extension String : PacketEncodableMojangJava {
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = Array(self.utf8)
        array.insert(contentsOf: try VariableIntegerJava(value: Int32(count)).packet_bytes(), at: 0)
        return array
    }
}
extension UUID : PacketEncodableMojangJava {
    public func packet_bytes() throws -> [UInt8] {
        let bytes:(UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8) = self.uuid
        return [
            bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5, bytes.6, bytes.7,
            bytes.8, bytes.9, bytes.10, bytes.11, bytes.12, bytes.13, bytes.14, bytes.15
        ]
    }
}

extension Data : PacketEncodableMojangJava {
    public func packet_bytes() throws -> [UInt8] {
        return Array(self)
    }
}

extension Bool : PacketEncodableMojangJava {
    public func packet_bytes() throws -> [UInt8] {
        return [self ? 1 : 0]
    }
}
