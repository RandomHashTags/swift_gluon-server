//
//  CPMPExplosion.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent when an explosion occurs (creepers, TNT, and ghast fireballs).
    ///
    /// Each block in Records is set to air. Coordinates for each axis in record is int(X) + record.x
    struct Explosion : ClientPacketMojangPlayProtocol {
        public let x:Double
        public let y:Double
        public let z:Double
        /// A strength greater than or equal to 2.0 spawns a `minecraft:explosion_emitter` particle, while a lesser strength spawns a `minecraft:explosion` particle.
        public let strength:Float
        /// Number of elements in `records`.
        public let record_count:Int
        /// as! [(Int, Int, Int)]
        /// Each record is 3 signed bytes long; the 3 bytes are the XYZ (respectively) signed offsets of affected blocks.
        public let records:Data // TODO: make [(Int, Int, Int)]
        /// X velocity of the player being pushed by the explosion.
        public let player_motion_x:Float
        /// Y velocity of the player being pushed by the explosion.
        public let player_motion_y:Float
        /// Z velocity of the player being pushed by the explosion.
        public let player_motion_z:Float
    }
}
