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
    var isCancelled:Bool = false
    
    init(entity: any Entity, new_location: any Location) {
        self.entity = entity
        self.new_location = new_location
    }
}
