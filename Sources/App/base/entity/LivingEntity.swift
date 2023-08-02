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
    
    var air_remaining_ticks : UInt16 { get set }
    var air_maximum_ticks : UInt16 { get set }
    
    var living_entity_executable_context : [String:ExecutableLogicalContext] { get }
    
    func tick_living_entity(_ server: any Server)
    
    func damage_living_entity(cause: DamageCause, amount: Double) -> DamageResult
}

public extension LivingEntity {
    var living_entity_executable_context : [String:ExecutableLogicalContext] {
        var context:[String:ExecutableLogicalContext] = damageable_executable_context
        context["air_remaining"] = ExecutableLogicalContext(value_type: .short_unsigned, value: air_remaining_ticks)
        context["air_maximum"] = ExecutableLogicalContext(value_type: .short_unsigned, value: air_maximum_ticks)
        context["has_ai"] = ExecutableLogicalContext(value_type: .boolean, value: has_ai)
        context["is_swimming"] = ExecutableLogicalContext(value_type: .boolean, value: is_swimming)
        context["no_damage_ticks"] = ExecutableLogicalContext(value_type: .short_unsigned, value: no_damage_ticks)
        context["no_damage_ticks_maximum"] = ExecutableLogicalContext(value_type: .short_unsigned, value: no_damage_ticks_maximum)
        return context
    }
    
    func tick(_ server: any Server) {
        tick_living_entity(server)
    }
    func tick_living_entity(_ server: any Server) {
        default_tick_living_entity(server)
    }
    func default_tick_living_entity(_ server: any Server) {
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
    
    func damage_living_entity(cause: DamageCause, amount: Double) -> DamageResult {
        let result:DamageResult = damage(cause: cause, amount: amount)
        if no_damage_ticks == 0 {
            no_damage_ticks = no_damage_ticks_maximum
        }
        return result
    }
}

public extension LivingEntity {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        living_entity_server_tps_slowed(to: tps, divisor: divisor)
    }
    internal func living_entity_server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        no_damage_ticks /= divisor
        no_damage_ticks_maximum /= divisor
        
        if air_remaining_ticks != air_maximum_ticks {
            air_remaining_ticks /= divisor
            air_maximum_ticks /= divisor
        } else {
            air_maximum_ticks /= divisor
            air_remaining_ticks = air_maximum_ticks
        }
        
        for (_, potion_effect) in potion_effects {
            potion_effect.server_tps_slowed(to: tps, divisor: divisor)
        }
        (self as any Entity).server_tps_slowed(to: tps, divisor: divisor)
    }
    
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        living_entity_server_tps_increased(to: tps, multiplier: multiplier)
    }
    internal func living_entity_server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        no_damage_ticks *= multiplier
        no_damage_ticks_maximum *= multiplier
        
        air_remaining_ticks *= multiplier
        air_maximum_ticks *= multiplier
        
        for (_, potion_effect) in potion_effects {
            potion_effect.server_tps_increased(to: tps, multiplier: multiplier)
        }
        (self as any Entity).server_tps_increased(to: tps, multiplier: multiplier)
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
