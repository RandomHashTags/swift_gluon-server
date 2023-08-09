//
//  PositionPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

/// An integer/block position: x (-33554432 to 33554431), z (-33554432 to 33554431), y (-2048 to 2047).
///
/// x as a 26-bit integer, followed by z as a 26-bit integer, followed by y as a 12-bit integer (all signed, two's complement).
public struct PositionPacketMojang : Hashable, Codable, PacketEncodableMojang, PacketDecodableMojang { // TODO: fix
    public static func decode(from packet: GeneralPacketMojang) throws -> PositionPacketMojang { // TODO: fix
        return Self()
    }
    
    
    public func packet_bytes() throws -> [UInt8] { // TODO: fix
        return []
    }
}
