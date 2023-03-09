//
//  PlayerItemConsumeEvent.swift
//  
//
//  Created by Evan Anderson on 3/8/23.
//

import Foundation

public class PlayerItemConsumeEvent : PlayerEvent, Cancellable {
    public let type:EventType
    public let player:Player
    public var is_cancelled:Bool
    public var item:ItemStack
    
    public init(player: Player, item: inout ItemStack) {
        type = EventType.player_item_consume
        self.player = player
        is_cancelled = false
        self.item = item
    }
    
    public func get_context(key: String) -> ExecutableLogicalContext? {
        switch key {
        case "item":
            return ExecutableLogicalContext(value_type: .item_stack, value: item)
        default:
            return parse_player_context(key: key, player: player)
        }
    }
}
