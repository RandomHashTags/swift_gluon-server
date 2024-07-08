//
//  CPMPHurtAnimation.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Plays a bobbing animation for the entity receiving damage.
    struct HurtAnimation : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.hurt_animation
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let yaw:Float = try packet.readFloat()
            return Self(entityID: entityID, yaw: yaw)
        }
        
        /// The ID of the entity taking damage
        public let entityID:VariableIntegerJava
        /// The direction the damage is coming from in relation to the entity
        public let yaw:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, yaw]
        }
    }
}
