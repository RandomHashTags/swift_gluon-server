//
//  SPMJCFinishConfiguration.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Configuration {
    /// Sent by the client to notify the client that the configuration process has finished. It is sent in response to the server's [Finish Configuration](https://wiki.vg/Protocol#Finish_Configuration ).
    struct FinishConfiguration : ServerPacketMojangJavaConfigurationProtocol {
        public static let id:ServerPacket.Mojang.Java.Configuration = ServerPacket.Mojang.Java.Configuration.finish_configuration
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            return Self()
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return []
        }
    }
}
