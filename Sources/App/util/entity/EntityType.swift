//
//  EntityType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct EntityType : Hashable {
    public let identifier:String
    
    public let is_affected_by_gravity:Bool
    
    public let receives_fall_damage:Bool
    
    public var no_damage_ticks_maximum:UInt16
    public var fire_ticks_maximum:UInt16
    public var freeze_ticks_maximum:UInt16
}
