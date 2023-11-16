//
//  CPMCRegistryData.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    /// Represents certain registries that are sent from the server and are applied on the client.
    struct RegistryData : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.registry_data
        
        // TODO: fix (supposed to be a NBT Tag Compound, not a string)
        /// See [Registry Data](https://wiki.vg/Registry_Data ).
        public let registry_codec:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [registry_codec]
        }
    }
}
