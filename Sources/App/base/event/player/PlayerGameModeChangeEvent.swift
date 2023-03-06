//
//  PlayerGameModeChangeEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public final class PlayerGameModeChangeEvent : PlayerEventCancellable {
    public let type:EventType
    public var is_cancelled:Bool
    public let player:Player, new_game_mode:GameMode
    
    public init(player: Player, new_game_mode: GameMode) {
        type = EventType.player_change_game_mode
        is_cancelled = false
        self.player = player
        self.new_game_mode = new_game_mode
    }
    
    public func get_context(key: String) -> ExecutableLogicalContext? {
        switch key {
        case "new_game_mode":
            return ExecutableLogicalContext(value_type: .string, value: new_game_mode.identifier)
        default:
            return parse_player_context(key: key, player: player)
        }
    }
}
