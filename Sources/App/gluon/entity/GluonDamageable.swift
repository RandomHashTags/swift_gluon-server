//
//  GluonDamageable.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

/*
extension GluonLivingEntity {
    func damage_damageable(cause: DamageCause, amount: Double) -> DamageResult {
        return damage_gluon_damageable(self, cause: cause, amount: amount)
    }
}
extension GluonPlayer {
    func damage_damageable(cause: DamageCause, amount: Double) -> DamageResult {
        return damage_gluon_damageable(self, cause: cause, amount: amount)
    }
}

private func damage_gluon_damageable(_ damageable: inout any Damageable, cause: DamageCause, amount: Double) -> DamageResult {
    let new_health:Double = max(0, min(damageable.health-amount, damageable.health_maximum))
    let event:GluonEntityDamageEvent = GluonEntityDamageEvent(entity: damageable, cause: cause, amount: amount)
    GluonServer.shared_instance.call_event(event: event)
    guard !event.is_cancelled else {
        return DamageResult.failure(.cancelled)
    }
    damageable.health = new_health
    guard damageable.health != 0 else {
        // TODO: finish
        let event:GluonEntityDeathEvent = GluonEntityDeathEvent(entity: damageable)
        GluonServer.shared_instance.call_event(event: event)
        return DamageResult.success(.killed)
    }
    return DamageResult.success(.normal)
}
*/
