//
//  CPMPTeleportEntity.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is sent by the server when an entity moves more than 8 blocks.
    struct TeleportEntity : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let yaw:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            return Self(entity_id: entity_id, x: x, y: y, z: z, yaw: yaw, pitch: pitch)
        }
        
        public let entity_id:VariableInteger
        public let x:Double
        public let y:Double
        public let z:Double
        /// (Y Rot) New angle, not a delta.
        public let yaw:Float
        /// (X Rot) New angle, not a delta.
        public let pitch:Float
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [entity_id, x, y, z, yaw, pitch]
        }
    }
}
