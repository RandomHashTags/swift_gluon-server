//
//  EntityType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol EntityType : MultilingualName, Identifiable where ID == String {
    var is_affected_by_gravity : Bool { get }
    var is_damageable : Bool { get }
    
    var receives_fall_damage : Bool { get }
    
    var no_damage_ticks_maximum : UInt16 { get set }
    var fire_ticks_maximum : UInt16 { get set }
    var freeze_ticks_maximum : UInt16 { get set }
}
