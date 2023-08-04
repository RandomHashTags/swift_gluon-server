//
//  CPMPSpawnExperienceOrb.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Spawns one or more experience orbs.
    struct SpawnExperienceOrb : ClientPacketMojangPlayProtocol {
        public let entity_id:Int
        public let x:Double
        public let y:Double
        public let z:Double
        /// The amount of experience this orb will reward once collected.
        public let count:Int
    }
}
