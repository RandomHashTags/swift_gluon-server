//
//  GluonPlayerGameModeChangeEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonPlayerGameModeChangeEvent : PlayerGameModeChangeEvent {
    typealias TargetEventType = GluonEventType
    
    let type:TargetEventType = GluonEventType.player_change_game_mode
    var player:any Player
    var new_game_mode:any GameMode
    var is_cancelled:Bool = false
    
    init(player: any Player, new_game_mode: any GameMode) {
        self.player = player
        self.new_game_mode = new_game_mode
    }
    
    var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.player_executable_context
        context["new_game_mode"] = ExecutableLogicalContext(value_type: .string, value: new_game_mode.identifier)
        return context
    }
}
