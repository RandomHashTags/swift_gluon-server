//
//  CPMCPing.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    /// Packet is not used by the Notchian server. When sent to the client, client responds with a [Pong](https://wiki.vg/Protocol#Pong_.28configuration.29) packet with the same id.
    struct Ping : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.ping
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.read_int()
            return Self(id: id)
        }
        
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [id]
        }
    }
}
