//
//  CPMPHurtAnimation.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Plays a bobbing animation for the entity receiving damage.
    struct HurtAnimation : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.hurt_animation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let yaw:Float = try packet.read_float()
            return Self(entity_id: entity_id, yaw: yaw)
        }
        
        /// The ID of the entity taking damage
        public let entity_id:VariableInteger
        /// The direction the damage is coming from in relation to the entity
        public let yaw:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [entity_id, yaw]
        }
    }
}
