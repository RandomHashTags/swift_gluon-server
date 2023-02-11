//
//  EntityType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct EntityType : Jsonable {
    public let identifier:String
    public let name:MultilingualStrings
    
    public let is_affected_by_gravity:Bool
    public let is_damageable:Bool
    
    public let receives_fall_damage:Bool
    
    public var no_damage_ticks_maximum:UInt16
    public var fire_ticks_maximum:UInt16
    public var freeze_ticks_maximum:UInt16
}
