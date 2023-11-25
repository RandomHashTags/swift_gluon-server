//
//  CPMJCPing.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Configuration {
    /// Packet is not used by the Notchian server. When sent to the client, client responds with a [Pong](https://wiki.vg/Protocol#Pong_.28configuration.29) packet with the same id.
    struct Ping : ClientPacketMojangJavaConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.ping
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let id:Int32 = try packet.read_int()
            return Self(id: id)
        }
        
        public let id:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [id]
        }
    }
}
