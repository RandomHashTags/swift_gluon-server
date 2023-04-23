//
//  LivingEntity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol LivingEntity : Damageable {
    var can_breathe_underwater : Bool { get set }
    var can_pickup_items : Bool { get set }
    var has_ai : Bool { get set }
    
    var is_climbing : Bool { get set }
    var is_collidable : Bool { get set }
    var is_gliding : Bool { get set }
    var is_invisible : Bool { get set }
    var is_leashed : Bool { get set }
    var is_riptiding : Bool { get set }
    var is_sleeping : Bool { get set }
    var is_swimming : Bool { get set }
    
    var potion_effects:Set<PotionEffect> { get set }
    
    var no_damage_ticks : UInt16 { get set }
    var no_damage_ticks_maximum : UInt16 { get set }
    
    var air_remaining : UInt16 { get set }
    var air_maximum : UInt16 { get set }
    
    var living_entity_executable_context : [String:ExecutableLogicalContext] { get }
    
    mutating func tick_living_entity(_ server: GluonServer)
    
    mutating func damage_living_entity(cause: DamageCause, amount: Double) -> DamageResult
}

public extension LivingEntity {
    
    var living_entity_executable_context : [String:ExecutableLogicalContext] {
        var context:[String:ExecutableLogicalContext] = damageable_executable_context
        context["air_remaining"] = ExecutableLogicalContext(value_type: .short_unsigned, value: air_remaining)
        context["air_maximum"] = ExecutableLogicalContext(value_type: .short_unsigned, value: air_maximum)
        context["has_ai"] = ExecutableLogicalContext(value_type: .boolean, value: has_ai)
        context["is_swimming"] = ExecutableLogicalContext(value_type: .boolean, value: is_swimming)
        context["no_damage_ticks"] = ExecutableLogicalContext(value_type: .short_unsigned, value: no_damage_ticks)
        context["no_damage_ticks_maximum"] = ExecutableLogicalContext(value_type: .short_unsigned, value: no_damage_ticks_maximum)
        return context
    }
    
    mutating func tick_living_entity(_ server: GluonServer) {
        print("living entity with uuid " + uuid.uuidString + " has been ticked")
        if no_damage_ticks > 0 {
            no_damage_ticks -= 1
        }
        
        var removed_potion_effects:Set<PotionEffect> = Set<PotionEffect>()
        for potion_effect in potion_effects {
            potion_effect.tick(server)
            if potion_effect.duration == 0 {
                removed_potion_effects.insert(potion_effect)
            }
        }
        potion_effects.remove(contentsOf: removed_potion_effects)
        
        tick_damageable(server)
    }
    
    mutating func damage_living_entity(cause: DamageCause, amount: Double) -> DamageResult {
        let result:DamageResult = damage_damageable(cause: cause, amount: amount)
        if no_damage_ticks == 0 {
            no_damage_ticks = no_damage_ticks_maximum
        }
        return result
    }
}
