//
//  EntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class EntityDeathEvent : EntityEvent {
    public let type:EventType
    public let entity:any Entity
    
    public init(entity: any Entity) {
        type = EventType.entity_death
        self.entity = entity
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        return entity.entity_executable_context
    }
}
