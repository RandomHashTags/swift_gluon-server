//
//  CPMPTeleportEntity.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This packet is sent by the server when an entity moves more than 8 blocks.
    struct TeleportEntity : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.teleport_entity
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let x:Double = try packet.readDouble()
            let y:Double = try packet.readDouble()
            let z:Double = try packet.readDouble()
            let yaw:AngleMojang = try packet.readAngle()
            let pitch:AngleMojang = try packet.readAngle()
            return Self(entityID: entityID, x: x, y: y, z: z, yaw: yaw, pitch: pitch)
        }
        
        public let entityID:VariableIntegerJava
        public let x:Double
        public let y:Double
        public let z:Double
        /// (Y Rot) New angle, not a delta.
        public let yaw:AngleMojang
        /// (X Rot) New angle, not a delta.
        public let pitch:AngleMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, x, y, z, yaw, pitch]
        }
    }
}
