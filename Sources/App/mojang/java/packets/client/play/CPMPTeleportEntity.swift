//
//  CPMPTeleportEntity.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This packet is sent by the server when an entity moves more than 8 blocks.
    struct TeleportEntity : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.teleport_entity
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableIntegerJava = try packet.read_var_int()
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let yaw:AngleMojang = try packet.read_angle()
            let pitch:AngleMojang = try packet.read_angle()
            return Self(entity_id: entity_id, x: x, y: y, z: z, yaw: yaw, pitch: pitch)
        }
        
        public let entity_id:VariableIntegerJava
        public let x:Double
        public let y:Double
        public let z:Double
        /// (Y Rot) New angle, not a delta.
        public let yaw:AngleMojang
        /// (X Rot) New angle, not a delta.
        public let pitch:AngleMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entity_id, x, y, z, yaw, pitch]
        }
    }
}
