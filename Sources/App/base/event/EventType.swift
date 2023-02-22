//
//  EventType.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum EventType {
    
    case entity_damage_event
    case entity_death_event
    
    case player_join_event
    
    case custom(identifier: String, value: Any? = nil)
}
