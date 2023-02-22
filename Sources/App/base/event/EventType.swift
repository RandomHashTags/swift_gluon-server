//
//  EventType.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum EventType {
    
    case chunk_load
    case chunk_unload
    
    case entity_damage
    case entity_death
    case entity_teleport
    
    case player_change_game_mode
    case player_join
    
    case custom(identifier: String, value: Any? = nil)
}
