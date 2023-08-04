//
//  CPMPGameEvent.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct GameEvent : ClientPacketMojangProtocol {
        let event:GameEvent.Event
        /// Depends on Event.
        let value:Float
        
        public enum Event : UInt, Hashable, Codable {
            /// Value: Note: Displays message 'block.minecraft.spawn.not\_valid' (You have no home bed or charged respawn anchor, or it was obstructed) to the player.
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
            /// Note that 1 is only sent by notchian server when player has not yet achieved advancement "The end?", else 0 is sent.
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
            /// Value: Note: Sent when any player is struck by an arrow.
            case arrow_hit_player
            /// !
            ///
            /// Value: Note: Seems to change both sky color and lighting.
            ///
            /// Rain level ranging from 0 to 1.
            case rain_level_change
            /// !
            ///
            /// Value: Note: Seems to change both sky color and lighting (same as Rain level change, but doesn't start rain). It also requires rain to render by notchian client.
            ///
            /// Thunder level ranging from 0 to 1.
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
    }
}
