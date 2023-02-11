//
//  EntityEventCancellable.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class EntityEventCancellable : EventCancellable {
    public let entity:Entity
    
    public init(type: EventType, entity: Entity) {
        self.entity = entity
        super.init(type: type, is_async: false, is_cancelled: false)
    }
}
