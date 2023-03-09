//
//  EntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class EntityDeathEvent : EntityEvent {
    public let type:EventType
    public let entity:Entity
    
    public init(entity: Entity) {
        type = EventType.entity_death
        self.entity = entity
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        return entity.executable_context
    }
}
