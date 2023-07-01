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
    
    var potion_effects:[String : any PotionEffect] { get set }
    
    var no_damage_ticks : UInt16 { get set }
    var no_damage_ticks_maximum : UInt16 { get set }
    
    var air_remaining : UInt16 { get set }
    var air_maximum : UInt16 { get set }
    
    var living_entity_executable_context : [String:ExecutableLogicalContext] { get }
    
    mutating func tick_living_entity(_ server: any Server)
    
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
    
    mutating func tick(_ server: any Server) {
        tick_living_entity(server)
    }
    mutating func tick_living_entity(_ server: any Server) {
        default_tick_living_entity(server)
    }
    mutating func default_tick_living_entity(_ server: any Server) {
        print("living entity with uuid \(uuid) has been ticked")
        if no_damage_ticks > 0 {
            no_damage_ticks -= 1
        }
        
        var removed_potion_effects:Set<String> = Set<String>()
        for (identifier, _) in potion_effects {
            potion_effects[identifier]!.tick(server)
            if potion_effects[identifier]!.duration == 0 {
                removed_potion_effects.insert(identifier)
            }
        }
        for identifier in removed_potion_effects {
            potion_effects.removeValue(forKey: identifier)
        }
        
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

public enum LivingEntityCodingKeys : CodingKey {
    case can_breathe_underwater
    case can_pickup_items
    case has_ai
    
    case is_climbing
    case is_collidable
    case is_gliding
    case is_invisible
    case is_leashed
    case is_riptiding
    case is_sleeping
    case is_swimming

    case potion_effects
    
    case no_damage_ticks
    case no_damage_ticks_maximum
    
    case air_remaining
    case air_maximum
}
