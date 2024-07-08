//
//  CPMPSpawnExperienceOrb.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Spawns one or more experience orbs.
    struct SpawnExperienceOrb : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.spawn_experience_orb
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let x:Double = try packet.readDouble()
            let y:Double = try packet.readDouble()
            let z:Double = try packet.readDouble()
            let count:Int16 = try packet.readShort()
            return Self(entityID: entityID, x: x, y: y, z: z, count: count)
        }
        
        public let entityID:VariableIntegerJava
        public let x:Double
        public let y:Double
        public let z:Double
        /// The amount of experience this orb will reward once collected.
        public let count:Int16
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                entityID,
                x,
                y,
                z,
                count
            ]
        }
    }
}
