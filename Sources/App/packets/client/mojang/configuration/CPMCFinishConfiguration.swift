//
//  CPMCFinishConfiguration.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    /// Sent by the server to notify the client that the configuration process has finished. The client answers with its own [Finish Configuration](https://wiki.vg/Protocol#Finish_Configuration_2) whenever it is ready to continue.
    struct FinishConfiguration : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.finish_configuration
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return []
        }
    }
}
