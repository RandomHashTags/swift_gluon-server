//
//  GluonPlayerJoinEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonPlayerJoinEvent : PlayerJoinEvent {
    let type:any EventType = GluonEventType.player_join
    var player:any Player
    var context : [String : ExecutableLogicalContext]? {
        return player.player_executable_context
    }
    
    init(_ player: any Player) {
        self.player = player
    }
}
