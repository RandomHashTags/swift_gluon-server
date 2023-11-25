//
//  CPMJCRegistryData.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Configuration {
    /// Represents certain registries that are sent from the server and are applied on the client.
    struct RegistryData : ClientPacketMojangJavaConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.registry_data
        
        // TODO: fix (supposed to be a NBT Tag Compound, not a string)
        /// See [Registry Data](https://wiki.vg/Registry_Data ).
        public let registry_codec:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [registry_codec]
        }
    }
}
