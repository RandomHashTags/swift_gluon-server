//
//  EventType.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum EventType {
    
    case entity_damage
    case entity_death
    
    case player_change_game_mode
    case player_join
    
    case custom(identifier: String, value: Any? = nil)
}
