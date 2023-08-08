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
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let count:Int16 = try packet.read_short()
            return Self(entity_id: entity_id, x: x, y: y, z: z, count: count)
        }
        
        public let entity_id:VariableInteger
        public let x:Double
        public let y:Double
        public let z:Double
        /// The amount of experience this orb will reward once collected.
        public let count:Int16
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [
                entity_id,
                x,
                y,
                z,
                count
            ]
        }
    }
}
