//
//  SPMPPlayerCommand.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Sent by the client to indicate that it has performed certain actions: sneaking (crouching), sprinting, exiting a bed, jumping with a horse, and opening a horse's inventory while riding it.
    ///
    /// Leave bed is only sent when the “Leave Bed” button is clicked on the sleep GUI, not when waking up due today time.
    /// 
    /// Open horse inventory is only sent when pressing the inventory key (default: E) while on a horse — all other methods of opening a horse's inventory (involving right-clicking or shift-right-clicking it) do not use this packet.
    struct PlayerCommand : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.player_command
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let action:PlayerCommand.Action = try packet.readEnum()
            let jump_boost:VariableIntegerJava = try packet.readVarInt()
            return Self(entityID: entityID, action: action, jump_boost: jump_boost)
        }
        
        public let entityID:VariableIntegerJava
        public let action:PlayerCommand.Action
        public let jump_boost:VariableIntegerJava
        
        public enum Action : Int, Codable, PacketEncodableMojangJava {
            case start_sneaking
            case stop_sneaking
            case leave_bed
            case start_sprinting
            case stop_sprinting
            case start_jump_with_horse
            case stop_jump_with_horse
            case open_horse_inventory
            case start_flying_with_elytra
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [entityID, action, jump_boost]
        }
    }
}
