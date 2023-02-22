//
//  EntityEvent.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class EntityEvent : Event {
    public let entity:Entity
    
    public init(type: EventType, entity: Entity) {
        self.entity = entity
        super.init(type: type)
    }
}
