//
//  LivingEntity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol LivingEntity : Damageable {
    var can_breathe_underwater:Bool { get set }
    var can_pickup_items:Bool { get set }
    var has_ai:Bool { get set }
    
    var is_climbing:Bool { get set }
    var is_collidable:Bool { get set }
    var is_gliding:Bool { get set }
    var is_invisible:Bool { get set }
    var is_leashed:Bool { get set }
    var is_riptiding:Bool { get set }
    var is_sleeping:Bool { get set }
    var is_swimming:Bool { get set }
    
    var potion_effects:Set<PotionEffect> { get set }
    
    var no_damage_ticks:UInt16 { get set }
    var no_damage_ticks_maximum:UInt16 { get set }
    
    var air_remaining:UInt16 { get set }
    var air_maximum:UInt16 { get set }
    
    func tick_living_entity()
}
