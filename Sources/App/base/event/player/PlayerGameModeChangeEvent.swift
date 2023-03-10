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
    
    public var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.executable_context
        context["new_game_mode"] = ExecutableLogicalContext(value_type: .string, value: new_game_mode.identifier)
        return context
    }
}
