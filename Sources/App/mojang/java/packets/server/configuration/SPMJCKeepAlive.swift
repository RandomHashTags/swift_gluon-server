//
//  SPMJCKeepAlive.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Configuration {
    /// The server will frequently send out a keep-alive (see [Clientbound Keep Alive](https://wiki.vg/Protocol#Clientbound_Keep_Alive_.28configuration.29 )), each containing a random ID. The client must respond with the same packet.
    struct KeepAlive : ServerPacketMojangJavaConfigurationProtocol {
        public static let id:ServerPacket.Mojang.Java.Configuration = ServerPacket.Mojang.Java.Configuration.keep_alive
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let keep_alive_id:Int64 = try packet.readLong()
            return Self(keep_alive_id: keep_alive_id)
        }
        
        public let keep_alive_id:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [keep_alive_id]
        }
    }
}
