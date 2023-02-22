//
//  PlayerEvent.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public class PlayerEvent : Event {
    public let player:Player
    
    public init(type: EventType, player: Player) {
        self.player = player
        super.init(type: type)
    }
}
