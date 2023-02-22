//
//  EntityTeleportEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class EntityTeleportEvent : EntityEventCancellable {
    public let type:EventType
    public var is_cancelled:Bool
    public let entity:Entity, new_location:Location
    
    public init(entity: Entity, new_location: Location) {
        type = EventType.entity_teleport
        is_cancelled = false
        self.entity = entity
        self.new_location = new_location
    }
}
