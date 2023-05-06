//
//  GluonEntityDamageEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEntityDamageEvent : EntityDamageEvent {
    typealias TargetEventType = GluonEventType
    
    let type:TargetEventType = GluonEventType.entity_damage
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
    
    var context : [String : ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = entity.entity_executable_context
        context["damage_amount"] = ExecutableLogicalContext(value_type: .double, value: amount)
        context["will_die"] = ExecutableLogicalContext(value_type: .boolean, value: will_die)
        context["damage_cause"] = ExecutableLogicalContext(value_type: .string, value: cause.identifier)
        return context
    }
}
