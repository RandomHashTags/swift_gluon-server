//
//  GluonPlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonPlayerItemConsumeEvent : PlayerItemConsumeEvent {
    let type:any EventType = GluonEventType.player_item_consume
    var player:any Player
    var item:ItemStack
    var isCancelled:Bool = false
    
    init(player: any Player, item: inout ItemStack) {
        self.player = player
        self.item = item
    }
}
