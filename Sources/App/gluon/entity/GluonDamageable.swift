//
//  GluonDamageable.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

extension Damageable {
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
