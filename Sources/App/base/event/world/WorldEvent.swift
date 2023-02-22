//
//  WorldEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public class WorldEvent : Event {
    public let world:World
    
    public init(type: EventType, world: World) {
        self.world = world
        super.init(type: type)
    }
}
