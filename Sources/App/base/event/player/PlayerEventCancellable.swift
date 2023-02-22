//
//  PlayerEventCancellable.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class PlayerEventCancellable : EventCancellable {
    public let player:Player
    
    public init(type: EventType, player: Player) {
        self.player = player
        super.init(type: type, is_cancelled: false)
    }
}
