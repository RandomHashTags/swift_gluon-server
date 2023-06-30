//
//  GluonEntityTeleportEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEntityTeleportEvent : EntityTeleportEvent {
    let type:any EventType = GluonEventType.entity_teleport
    var entity:any Entity
    var new_location:any Location
    var is_cancelled:Bool = false
    
    init(entity: any Entity, new_location: any Location) {
        self.entity = entity
        self.new_location = new_location
    }
    
    var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = entity.entity_executable_context
        context["new_location"] = ExecutableLogicalContext(value_type: .location, value: new_location)
        return context
    }
}
