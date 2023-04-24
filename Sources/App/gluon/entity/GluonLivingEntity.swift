//
//  GluonLivingEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonLivingEntity : LivingEntity {
    public typealias TargetPotionEffect = GluonPotionEffect
    public typealias TargetLocation = GluonLocation
    
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
    
    public var no_damage_ticks:UInt16
    public var no_damage_ticks_maximum:UInt16
    
    public var air_remaining:UInt16
    public var air_maximum:UInt16
    
    public var health:Double
    public var health_maximum:Double
    
    public var uuid:UUID
    public var type:EntityType
    public var ticks_lived:UInt64
    public var custom_name:String?
    public var display_name:String?
    
    public var boundaries:[Boundary]
    public var location:TargetLocation
    public var velocity:Vector
    
    public var fall_distance:Float
    
    public var is_glowing:Bool
    public var is_on_fire:Bool
    public var is_on_ground:Bool
    
    public var height:Float
    
    public var fire_ticks:UInt16
    public var fire_ticks_maximum:UInt16
    public var freeze_ticks:UInt16
    public var freeze_ticks_maximum:UInt16
    
    public var passenger_uuids:Set<UUID>
    public var passengers : [any Entity] {
        return GluonServer.shared_instance.get_entities(uuids: passenger_uuids)
    }
    
    public var vehicle_uuid:UUID?
    public var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    init(
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
        is_swimming: Bool,
        no_damage_ticks: UInt16,
        no_damage_ticks_maximum: UInt16,
        air_remaining: UInt16,
        air_maximum: UInt16,
        health: Double,
        health_maximum: Double,
        uuid: UUID,
        type: EntityType,
        ticks_lived: UInt64,
        custom_name: String? = nil,
        display_name: String? = nil,
        boundaries: [Boundary],
        location: TargetLocation,
        velocity: Vector,
        fall_distance: Float,
        is_glowing: Bool,
        is_on_fire: Bool,
        is_on_ground: Bool,
        height: Float,
        fire_ticks: UInt16,
        fire_ticks_maximum: UInt16,
        freeze_ticks: UInt16,
        freeze_ticks_maximum: UInt16,
        passenger_uuids: Set<UUID>,
        vehicle_uuid: UUID? = nil
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
        self.no_damage_ticks = no_damage_ticks
        self.no_damage_ticks_maximum = no_damage_ticks_maximum
        self.air_remaining = air_remaining
        self.air_maximum = air_maximum
        self.health = health
        self.health_maximum = health_maximum
        self.uuid = uuid
        self.type = type
        self.ticks_lived = ticks_lived
        self.custom_name = custom_name
        self.display_name = display_name
        self.boundaries = boundaries
        self.location = location
        self.velocity = velocity
        self.fall_distance = fall_distance
        self.is_glowing = is_glowing
        self.is_on_fire = is_on_fire
        self.is_on_ground = is_on_ground
        self.height = height
        self.fire_ticks = fire_ticks
        self.fire_ticks_maximum = fire_ticks_maximum
        self.freeze_ticks = freeze_ticks
        self.freeze_ticks_maximum = freeze_ticks_maximum
        self.passenger_uuids = passenger_uuids
        self.vehicle_uuid = vehicle_uuid
    }
    
    public mutating func tick(_ server: any Server) {
        tick_living_entity(server)
    }
    
    public func save() {
    }
}
