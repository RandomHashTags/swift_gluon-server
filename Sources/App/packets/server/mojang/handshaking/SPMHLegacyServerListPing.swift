//
//  SPMHLegacyServerListPing.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Handshaking {
    /// While not technically part of the current protocol, legacy clients may send this packet to initiate Server List Ping, and modern servers should handle it correctly. The format of this packet is a remnant of the pre-Netty age, before the switch to Netty in 1.7 brought the standard format that is recognized now. This packet merely exists to inform legacy clients that they can't join our modern server.
    /// - Warning: This packet uses a nonstandard format. It is never length-prefixed, and the packet ID is an Unsigned Byte instead of a VarInt.
    struct LegacyServerListPing : ServerPacketMojangHandshakingProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let payload:UInt8 = try packet.read_unsigned_byte()
            return Self(payload: payload)
        }
        
        /// always 1 (`0x01`).
        public let payload:UInt8
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [payload]
        }
    }
}
