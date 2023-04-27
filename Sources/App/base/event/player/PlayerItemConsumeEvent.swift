//
//  PlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public class PlayerItemConsumeEvent<T: ItemStack> : PlayerEvent, Cancellable {
    public let type:EventType
    public let player:any Player
    public var is_cancelled:Bool
    public var item:T
    
    public init(player: any Player, item: inout T) {
        type = EventType.player_item_consume
        self.player = player
        is_cancelled = false
        self.item = item
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = player.player_executable_context
        context["item"] = ExecutableLogicalContext(value_type: .item_stack, value: item)
        return context
    }
}
