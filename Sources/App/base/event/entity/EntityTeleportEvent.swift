//
//  EntityTeleportEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class EntityTeleportEvent : EntityEventCancellable {
    public let new_location:Location
    
    public init(entity: Entity, new_location: Location) {
        self.new_location = new_location
        super.init(type: EventType.entity_teleport, entity: entity)
    }
}
