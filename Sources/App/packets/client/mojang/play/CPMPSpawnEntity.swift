//
//  CPMPSpawnEntity.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server when a vehicle or other non-living entity is created.
    struct SpawnEntity : ClientPacketMojangPlayProtocol {
        /// A unique integer ID mostly used to identify the entity.
        public let entity_id:VariableInteger
        /// A unique identifier that is mostly used in persistence and places where the uniqueness matters more.
        public let entity_uuid:UUID
        /// The type of the entity.
        public let type:VariableInteger
        public let x:Double
        public let y:Double
        public let z:Double
        /// To get the real pitch, you must divide this by (256.0F / 360.0F)
        public let pitch:Float
        /// To get the real yaw, you must divide this by (256.0F / 360.0F)
        public let yaw:Float
        /// Only used by living entities, where the head of the entity may differ from the general body rotation.
        public let head_yaw:Float
        public let data:VariableInteger
        public let velocity_x:Int
        public let velocity_y:Int
        public let velocity_z:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [
                entity_id,
                entity_uuid,
                type,
                x,
                y,
                z,
                pitch,
                yaw,
                head_yaw,
                data,
                velocity_x,
                velocity_y,
                velocity_z
            ]
        }
    }
}
