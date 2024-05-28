//
//  GluonEntityDamageEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEntityDamageEvent : EntityDamageEvent {
    let type:any EventType = GluonEventType.entity_damage
    var cause:DamageCause
    var amount:Double
    
    var will_die : Bool {
        return entity is (any LivingEntity) && (entity as! (any LivingEntity)).health - amount <= 0
    }
    
    var entity:any Entity
    var is_cancelled:Bool = false
    
    init(entity: any Entity, cause: DamageCause, amount: Double) {
        self.entity = entity
        self.cause = cause
        self.amount = amount
    }
}
