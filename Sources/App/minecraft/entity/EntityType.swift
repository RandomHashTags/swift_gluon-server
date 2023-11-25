//
//  EntityType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol EntityType : AnyObject, MultilingualName, ServerTickChangeListener, Identifiable where ID == String {
    var is_affected_by_gravity : Bool { get }
    var is_damageable : Bool { get }
    
    var receives_fall_damage : Bool { get }
    
    var no_damage_ticks_maximum : UInt16 { get set }
    var fire_ticks_maximum : UInt16 { get set }
    var freeze_ticks_maximum : UInt16 { get set }
}

public extension EntityType {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        no_damage_ticks_maximum /= divisor
        fire_ticks_maximum /= divisor
        freeze_ticks_maximum /= divisor
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        freeze_ticks_maximum *= multiplier
        fire_ticks_maximum *= multiplier
        freeze_ticks_maximum *= multiplier
    }
}
