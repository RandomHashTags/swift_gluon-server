//
//  CPMPGameEvent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    struct GameEvent : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.game_event
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let event:GameEvent.Event = try packet.read_enum()
            let value:Float = try packet.read_float()
            return Self(event: event, value: value)
        }
        
        public let event:GameEvent.Event
        /// Depends on Event.
        public let value:Float
        
        public enum Event : Int, Hashable, Codable, PacketEncodableMojangJava {
            /// > Note: Displays message 'block.minecraft.spawn.not\_valid' (You have no home bed or charged respawn anchor, or it was obstructed) to the player.
            case no_respawn_block_available
            case begin_raining
            case end_raining
            /// !
            ///
            /// Value:
            /// - 0: Survival
            /// - 1: Creative
            /// - 2: Adventure
            /// - 3: Spectator
            case change_game_mode
            /// !
            ///
            /// Value:
            /// - 0: Just respawn player.
            /// - 1: Roll the credits and respawn player.
            ///
            /// > Note: 1 is only sent by notchian server when player has not yet achieved advancement "The end?", else 0 is sent.
            case win_game
            /// !
            ///
            /// Value:
            /// - 0: Show welcome to demo screen.
            /// - 101: Tell movement controls.
            /// - 102: Tell jump control.
            /// - 103: Tell inventory control.
            /// - 104: Tell that the demo is over and print a message about how to take a screenshot.
            case demo_event
            /// > Note: Sent when any player is struck by an arrow.
            case arrow_hit_player
            /// !
            ///
            /// Value: Rain level ranging from 0 to 1.
            /// > Note: Seems to change both sky color and lighting.
            case rain_level_change
            /// !
            ///
            /// Value: Thunder level ranging from 0 to 1.
            /// > Note: Seems to change both sky color and lighting (same as Rain level change, but doesn't start rain). It also requires rain to render by notchian client.
            case thunder_level_change
            case play_pufferfish_sting_sound
            case play_elder_guardian_mob_appearance // effect and sound
            /// !
            ///
            /// Value:
            /// - 0: Enable respawn screen.
            /// - 1: Immediately respawn (sent when the doImmediateRespawn gamerule changes).
            case enable_respawn_screen
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [event, value]
        }
    }
}
