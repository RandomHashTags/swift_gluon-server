//
//  CPMPEntityAnimation.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Sent whenever an entity should change animation.
    struct EntityAnimation : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.entity_animation
        
        public let entity_id:VariableIntegerJava
        public let animation_id:Int
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entity_id, animation_id]
        }
    }
}
