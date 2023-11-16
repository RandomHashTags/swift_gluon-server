//
//  CPMCUpdateTags.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacketMojang.Configuration {
    // TODO: fix
    struct UpdateTags : ClientPacketMojangConfigurationProtocol {
        public static let id:ClientPacketMojangConfiguration = ClientPacketMojangConfiguration.update_tags
        
        public let length_of_the_array:VariableInteger
        public let tag_identifiers:[Namespace]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [length_of_the_array]
        }
    }
}
