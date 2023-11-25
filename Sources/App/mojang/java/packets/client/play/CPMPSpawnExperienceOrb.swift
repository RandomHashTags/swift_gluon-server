//
//  CPMPSpawnExperienceOrb.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Spawns one or more experience orbs.
    struct SpawnExperienceOrb : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.spawn_experience_orb
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableIntegerJava = try packet.read_var_int()
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let count:Int16 = try packet.read_short()
            return Self(entity_id: entity_id, x: x, y: y, z: z, count: count)
        }
        
        public let entity_id:VariableIntegerJava
        public let x:Double
        public let y:Double
        public let z:Double
        /// The amount of experience this orb will reward once collected.
        public let count:Int16
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
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
