//
//  EntityDamageEvent.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class EntityDamageEvent : EntityEventCancellable {
    public let cause:DamageCause
    public var amount:Double
    public var will_die : Bool {
        return entity is LivingEntity && (entity as! LivingEntity).health - amount <= 0
    }
    
    public init(entity: Entity, cause: DamageCause, amount: Double) {
        self.cause = cause
        self.amount = amount
        super.init(type: EventType.entity_damage_event, entity: entity)
    }
}
