//
//  SPMPTeleportToEntity.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Teleports the player to the given entity. The player must be in spectator mode.
    ///
    /// The Notchian client only uses this to teleport to players, but it appears to accept any type of entity. The entity does not need to be in the same dimension as the player; if necessary, the player will be respawned in the right world. If the given entity cannot be found (or isn't loaded), this packet will be ignored. It will also be ignored if the player attempts to teleport to themselves.
    struct TeleportToEntity : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.teleport_to_entity
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let target_player:UUID = try packet.readUUID()
            return Self(target_player: target_player)
        }
        
        /// UUID of the player to teleport to (can also be an entity UUID).
        public let target_player:UUID
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [target_player]
        }
    }
}
