//
//  SPMCFinishConfiguration.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ServerPacketMojang.Configuration {
    /// Sent by the client to notify the client that the configuration process has finished. It is sent in response to the server's [Finish Configuration](https://wiki.vg/Protocol#Finish_Configuration ).
    struct FinishConfiguration : ServerPacketMojangConfigurationProtocol {
        public static let id:ServerPacketMojangConfiguration = ServerPacketMojangConfiguration.finish_configuration
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            return Self()
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return []
        }
    }
}
