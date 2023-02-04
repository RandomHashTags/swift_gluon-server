//
//  LivingEntity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class LivingEntity : Damageable {
    public var can_breathe_underwater:Bool
    public var can_pickup_items:Bool
    public var has_ai:Bool
    
    public var is_climbing:Bool
    public var is_collidable:Bool
    public var is_gliding:Bool
    public var is_invisible:Bool
    public var is_leashed:Bool
    public var is_riptiding:Bool
    public var is_sleeping:Bool
    public var is_swimming:Bool
    
    public init(
        uuid: UInt64,
        type: UnsafePointer<EntityType>,
        can_breathe_underwater: Bool,
        can_pickup_items: Bool,
        has_ai: Bool,
        is_climbing: Bool,
        is_collidable: Bool,
        is_gliding: Bool,
        is_invisible: Bool,
        is_leashed: Bool,
        is_riptiding: Bool,
        is_sleeping: Bool,
        is_swimming: Bool
    ) {
        self.can_breathe_underwater = can_breathe_underwater
        self.can_pickup_items = can_pickup_items
        self.has_ai = has_ai
        self.is_climbing = is_climbing
        self.is_collidable = is_collidable
        self.is_gliding = is_gliding
        self.is_invisible = is_invisible
        self.is_leashed = is_leashed
        self.is_riptiding = is_riptiding
        self.is_sleeping = is_sleeping
        self.is_swimming = is_swimming
        super.init(uuid: uuid, type: type, health: 20, health_maximum: 20)
    }
    
    public override func tick() {
        // TODO: LivingEntity tick logic
        super.tick()
    }
}
