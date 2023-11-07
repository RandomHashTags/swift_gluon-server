//
//  CPMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.entity_animation
        
        public let entity_id:VariableInteger
        public let animation_id:Int
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [entity_id, animation_id]
        }
    }
}
