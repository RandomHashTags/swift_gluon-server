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
    
    init(_ player: any Player) {
        self.player = player
    }
}
