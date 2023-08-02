//
//  CPMSpawnEntity.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang {
    /// Sent by the server when a vehicle or other non-living entity is created.
    struct SpawnEntity : ClientPacketMojangProtocol {
        /// A unique integer ID mostly used to identify the entity.
        let entity_id:Int
        /// A unique identifier that is mostly used in persistence and places where the uniqueness matters more.
        let entity_uuid:UUID
        /// The type of the entity.
        let type:Int
        let x:Double
        let y:Double
        let z:Double
        /// To get the real pitch, you must divide this by (256.0F / 360.0F)
        let pitch:Float
        /// To get the real yaw, you must divide this by (256.0F / 360.0F)
        let yaw:Float
        /// Only used by living entities, where the head of the entity may differ from the general body rotation.
        let head_yaw:Float
        let data:Int
        let velocity_x:Int
        let velocity_y:Int
        let velocity_z:Int
    }
}
