//
//  GluonEntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEntityDeathEvent : EntityDeathEvent {
    let type:any EventType = GluonEventType.entity_death
    var entity:any Entity
    var context : [String : ExecutableLogicalContext]? {
        return entity.entity_executable_context
    }
    
    init(entity: any Entity) {
        self.entity = entity
    }
}
