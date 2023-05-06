//
//  EntityTeleportEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol EntityTeleportEvent : EntityEventCancellable {
    var new_location : any Location { get set }
    
    init(entity: any Entity, new_location: any Location)
    
    /*public init(entity: any Entity, new_location: any Location) {
        type = EventType.entity_teleport
        is_cancelled = false
        self.entity = entity
        self.new_location = new_location
    }
    
    public var context : [String:ExecutableLogicalContext]? {
        var context:[String:ExecutableLogicalContext] = entity.entity_executable_context
        context["new_location"] = ExecutableLogicalContext(value_type: .location, value: new_location)
        return context
    }*/
}
