//
//  PlayerJoinEvent.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public final class PlayerJoinEvent : PlayerEvent {
    public init(player: Player) {
        super.init(type: EventType.player_join, player: player)
    }
}
