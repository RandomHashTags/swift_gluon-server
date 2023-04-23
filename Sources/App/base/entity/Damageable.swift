//
//  Damageable.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Damageable : Entity {
    var health : Double { get set }
    var health_maximum : Double { get set }
    
    var damageable_executable_context : [String:ExecutableLogicalContext] { get }
    
    mutating func tick_damageable(_ server: GluonServer)
    
    mutating func damage_damageable(cause: DamageCause, amount: Double) -> DamageResult
}
public extension Damageable {
    
    var damageable_executable_context : [String:ExecutableLogicalContext] {
        var context:[String:ExecutableLogicalContext] = entity_executable_context
        context["health"] = ExecutableLogicalContext(value_type: .double, value: health)
        context["health_maximum"] = ExecutableLogicalContext(value_type: .double, value: health_maximum)
        return context
    }
    
    mutating func tick_damageable(_ server: GluonServer) {
        print("damageable with uuid " + uuid.uuidString + " has been ticked")
        if fire_ticks > 0 {
            fire_ticks -= 1
        }
        if freeze_ticks > 0 {
            freeze_ticks -= 1
        }
        tick_entity(server)
    }
    
    mutating func damage_damageable(cause: DamageCause, amount: Double) -> DamageResult {
        let new_health:Double = max(0, min(health-amount, health_maximum))
        let event:EntityDamageEvent = EntityDamageEvent(entity: self, cause: cause, amount: amount)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else {
            return DamageResult.failure(.cancelled)
        }
        health = new_health
        guard health == 0 else {
            // TODO: finish
            let event:EntityDeathEvent = EntityDeathEvent(entity: self)
            GluonServer.shared_instance.call_event(event: event)
            return DamageResult.success(.killed)
        }
        return DamageResult.success(.normal)
    }
}
