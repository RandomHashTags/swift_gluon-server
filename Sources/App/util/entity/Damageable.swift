//
//  Damageable.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Damageable : Entity {
    public var health:Float, health_maximum:Float
    
    public init(uuid: UInt64, type: UnsafePointer<EntityType>, health: Float, health_maximum: Float) {
        self.health = health
        self.health_maximum = health_maximum
        super.init(uuid: uuid, type: type, display_name: nil, fall_distance: 0)
    }
    
    public override func tick() {
        // TODO: Damageable tick logic
        super.tick()
    }
    
    public func damage(amount: Float) {
    }
}
