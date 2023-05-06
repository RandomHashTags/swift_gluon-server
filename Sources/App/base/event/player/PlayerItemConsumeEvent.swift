//
//  PlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public protocol PlayerItemConsumeEvent : PlayerEvent, Cancellable {    
    var item : any ItemStack { get set }
    
    /*public init(player: any Player, item: inout T) {
        type = EventType.player_item_consume
        self.player = player
        is_cancelled = false
        self.item = item
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.player_executable_context
        context["item"] = ExecutableLogicalContext(value_type: .item_stack, value: item)
        return context
    }*/
}
