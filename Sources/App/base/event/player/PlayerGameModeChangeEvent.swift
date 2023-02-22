//
//  PlayerGameModeChangeEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class PlayerGameModeChangeEvent : PlayerEventCancellable {
    public let new_game_mode:GameMode
    
    public init(player: Player, new_game_mode: GameMode) {
        self.new_game_mode = new_game_mode
        super.init(type: EventType.player_change_game_mode, player: player)
    }
}
