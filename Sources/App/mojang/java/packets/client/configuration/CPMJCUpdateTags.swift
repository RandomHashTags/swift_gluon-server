//
//  CPMJCUpdateTags.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Configuration {
    // TODO: fix
    struct UpdateTags : ClientPacketMojangJavaConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.update_tags
        
        public let length_of_the_array:VariableIntegerJava
        public let tag_identifiers:[Namespace]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [length_of_the_array]
        }
    }
}
