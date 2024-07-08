//
//  CPMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.entity_animation
        
        public let entityID:VariableIntegerJava
        public let animationID:Int
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, animationID]
        }
    }
}
