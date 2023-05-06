//
//  GluonEntityDeathEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEntityDeathEvent : EntityDeathEvent {
    typealias TargetEventType = GluonEventType
    
    let type:TargetEventType = GluonEventType.entity_death
    var entity:any Entity
    var context : [String : ExecutableLogicalContext]? {
        return entity.entity_executable_context
    }
    
    init(entity: any Entity) {
        self.entity = entity
    }
}
