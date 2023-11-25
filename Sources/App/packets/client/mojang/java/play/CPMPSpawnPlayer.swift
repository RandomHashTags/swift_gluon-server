//
//  CPMPSpawnPlayer.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// This packet is sent by the server when a player comes into visible range, not when a player joins.
    ///
    /// This packet must be sent after the Player Info Update packet that adds the player data for the client to use when spawning a player. If the Player Info for the player spawned by this packet is not present when this packet arrives, Notchian clients will not spawn the player entity. The Player Info packet includes skin/cape data.
    ///
    /// Servers can, however, safely spawn player entities for players not in visible range. The client appears to handle it correctly.
    struct SpawnPlayer : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.spawn_player
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_id:VariableInteger = try packet.read_var_int()
            let player_uuid:UUID = try packet.read_uuid()
            let x:Double = try packet.read_double()
            let y:Double = try packet.read_double()
            let z:Double = try packet.read_double()
            let yaw:AngleMojang = try packet.read_angle()
            let pitch:AngleMojang = try packet.read_angle()
            return Self(entity_id: entity_id, player_uuid: player_uuid, x: x, y: y, z: z, yaw: yaw, pitch: pitch)
        }
        
        /// A unique integer ID mostly used to identify the player.
        public let entity_id:VariableInteger
        public let player_uuid:UUID
        public let x:Double
        public let y:Double
        public let z:Double
        public let yaw:AngleMojang
        public let pitch:AngleMojang
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [
                entity_id,
                player_uuid,
                x,
                y,
                z,
                yaw,
                pitch
            ]
        }
    }
}
