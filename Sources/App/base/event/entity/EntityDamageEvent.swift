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
}
