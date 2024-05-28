//
//  GluonPlayerGameModeChangeEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonPlayerGameModeChangeEvent : PlayerGameModeChangeEvent {
    let type:any EventType = GluonEventType.player_change_game_mode
    var player:any Player
    var new_game_mode:any GameMode
    var is_cancelled:Bool = false
    
    init(player: any Player, new_game_mode: any GameMode) {
        self.player = player
        self.new_game_mode = new_game_mode
    }
}
