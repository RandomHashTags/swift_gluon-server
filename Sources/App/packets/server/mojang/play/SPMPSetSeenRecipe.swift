//
//  SPMPSetSeenRecipe.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when recipe is first seen in recipe book. Replaces Recipe Book Data, type 0.
    struct SetSeenRecipe : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.set_seen_recipe
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let recipe:Namespace = try packet.read_identifier()
            return Self(recipe: recipe)
        }
        
        public let recipe:Namespace
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [recipe]
        }
    }
}
