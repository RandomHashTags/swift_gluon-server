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
    var item:any ItemStack
    var is_cancelled:Bool = false
    
    init(player: any Player, item: inout any ItemStack) {
        self.player = player
        self.item = item
    }
    
    var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.player_executable_context
        context["item"] = ExecutableLogicalContext(value_type: .item_stack, value: item)
        return context
    }
}
