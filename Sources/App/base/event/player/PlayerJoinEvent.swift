//
//  PlayerJoinEvent.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public final class PlayerJoinEvent : PlayerEvent {
    public let type:EventType
    public var is_cancelled:Bool
    public let player:Player
    
    public init(player: Player) {
        type = EventType.player_join
        is_cancelled = false
        self.player = player
    }
    
    public func get_context(key: String) -> ExecutableLogicalContext? {
        return nil
    }
}
