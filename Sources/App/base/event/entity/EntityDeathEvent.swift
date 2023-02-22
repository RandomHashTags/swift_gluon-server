//
//  EntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class EntityDeathEvent : EntityEvent {
    public init(entity: Entity) {
        super.init(type: EventType.entity_death, entity: entity)
    }
}
