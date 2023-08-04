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
        public let entity_id:Int
        public let x:Double
        public let y:Double
        public let z:Double
        /// (Y Rot) New angle, not a delta.
        public let yaw:Float
        /// (X Rot) New angle, not a delta.
        public let pitch:Float
    }
}
