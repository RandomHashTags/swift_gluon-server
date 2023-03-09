//
//  EntityDamageEvent.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class EntityDamageEvent : EntityEventCancellable {
    public let type:EventType
    public var is_cancelled:Bool
    
    public let entity:Entity, cause:DamageCause
    public var amount:Double
    public var will_die : Bool {
        return entity is LivingEntity && (entity as! LivingEntity).health - amount <= 0
    }
        
    public init(entity: Entity, cause: DamageCause, amount: Double) {
        type = EventType.entity_damage
        is_cancelled = false
        self.entity = entity
        self.cause = cause
        self.amount = amount
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = entity.executable_context
        context["damage_amount"] = ExecutableLogicalContext(value_type: .double, value: amount)
        context["will_die"] = ExecutableLogicalContext(value_type: .boolean, value: will_die)
        context["damage_cause"] = ExecutableLogicalContext(value_type: .string, value: cause.identifier)
        return context
    }
}
