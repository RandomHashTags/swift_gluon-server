//
//  PacketEncodableMojang.swift
//
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketEncodableMojang : PacketEncodable {
}
public extension PacketEncodableMojang where Self : RawRepresentable, RawValue : PacketEncodableMojang {
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

extension Int : PacketEncodableMojang {}
extension Int8 : PacketEncodableMojang {}
extension Int16 : PacketEncodableMojang {}
extension Int32 : PacketEncodableMojang {}
extension Int64 : PacketEncodableMojang {}
extension UInt8 : PacketEncodableMojang {}
extension UInt16 : PacketEncodableMojang {}
extension UInt32 : PacketEncodableMojang {}
extension UInt64 : PacketEncodableMojang {}

extension Double : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = []
        return array
    }
}
extension Float : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = []
        return array
    }
}

extension String : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        var array:[UInt8] = Array(self.utf8)
        array.insert(contentsOf: try count.packet_bytes(), at: 0)
        return array
    }
}
extension UUID : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        let bytes = self.uuid
        return [
            bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5, bytes.6, bytes.7,
            bytes.8, bytes.9, bytes.10, bytes.11, bytes.12, bytes.13, bytes.14, bytes.15
        ]
    }
}

extension Data : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        return Array(self)
    }
}

extension Bool : PacketEncodableMojang {
    public func packet_bytes() throws -> [UInt8] {
        return [self ? 1 : 0]
    }
}
