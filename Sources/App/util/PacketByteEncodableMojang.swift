//
//  PacketByteEncodableMojang.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketByteEncodableMojang {
    var packet_bytes_mojang : [UInt8] { get }
}
public extension PacketByteEncodableMojang where Self : RawRepresentable, RawValue : PacketByteEncodableMojang {
    var packet_bytes_mojang : [UInt8] {
        return rawValue.packet_bytes_mojang
    }
}

extension Int : PacketByteEncodableMojang {
    public var packet_bytes_mojang : [UInt8] {
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
extension UInt8 : PacketByteEncodableMojang {
    public var packet_bytes_mojang : [UInt8] {
        var array:[UInt8] = []
        var value:UInt8 = self
        while true {
            if (value & ~GeneralPacketMojang.segment_bits) == 0 {
                array.append(value)
                break
            }
            array.append((value & GeneralPacketMojang.segment_bits) | GeneralPacketMojang.continue_bit)
            value >>= 7
        }
        return array
    }
}

extension String : PacketByteEncodableMojang {
    public var packet_bytes_mojang : [UInt8] {
        var array:[UInt8] = Array(self.utf8)
        array.insert(contentsOf: count.packet_bytes_mojang, at: 0)
        return array
    }
}

extension Data : PacketByteEncodableMojang {
    public var packet_bytes_mojang : [UInt8] {
        return Array(self)
    }
}

extension Bool : PacketByteEncodableMojang {
    public var packet_bytes_mojang : [UInt8] {
        return [self ? 1 : 0]
    }
}
