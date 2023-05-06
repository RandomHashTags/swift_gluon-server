//
//  GluonPlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonPlayerItemConsumeEvent : PlayerItemConsumeEvent {
    typealias TargetEventType = GluonEventType
    typealias TargetItemStack = GluonItemStack
    
    let type:TargetEventType = GluonEventType.player_item_consume
    var player:any Player
    var item:TargetItemStack
    var is_cancelled:Bool = false
    
    init(player: any Player, item: inout TargetItemStack) {
        self.player = player
        self.item = item
    }
    
    var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.player_executable_context
        context["item"] = ExecutableLogicalContext(value_type: .item_stack, value: item)
        return context
    }
}
