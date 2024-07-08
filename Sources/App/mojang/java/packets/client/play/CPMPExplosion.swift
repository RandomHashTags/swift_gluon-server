//
//  CPMPExplosion.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Sent when an explosion occurs (creepers, TNT, and ghast fireballs).
    ///
    /// Each block in Records is set to air. Coordinates for each axis in record is int(X) + record.x
    struct Explosion : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.explosion
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let x:Double = try packet.readDouble()
            let y:Double = try packet.readDouble()
            let z:Double = try packet.readDouble()
            let strength:Float = try packet.readFloat()
            let record_count:VariableIntegerJava = try packet.readVarInt()
            let data:Data = try packet.read_data(bytes: record_count.value_int * 3)
            let player_motion_x:Float = try packet.readFloat()
            let player_motion_y:Float = try packet.readFloat()
            let player_motion_z:Float = try packet.readFloat()
            return Self(x: x, y: y, z: z, strength: strength, record_count: record_count, records: data, player_motion_x: player_motion_x, player_motion_y: player_motion_y, player_motion_z: player_motion_z)
        }
        
        public let x:Double
        public let y:Double
        public let z:Double
        /// A strength greater than or equal to 2.0 spawns a `minecraft:explosion_emitter` particle, while a lesser strength spawns a `minecraft:explosion` particle.
        public let strength:Float
        /// Number of elements in `records`.
        public let record_count:VariableIntegerJava
        /// as! [(Int8, Int8, Int8)]
        /// Each record is 3 signed bytes long; the 3 bytes are the XYZ (respectively) signed offsets of affected blocks.
        public let records:Data // TODO: make [(Int8, Int8, Int8)]
        /// X velocity of the player being pushed by the explosion.
        public let player_motion_x:Float
        /// Y velocity of the player being pushed by the explosion.
        public let player_motion_y:Float
        /// Z velocity of the player being pushed by the explosion.
        public let player_motion_z:Float
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [
                x,
                y,
                z,
                strength,
                record_count,
                records,
                player_motion_x,
                player_motion_y,
                player_motion_z
            ]
        }
    }
}
