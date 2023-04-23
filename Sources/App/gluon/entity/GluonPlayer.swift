//
//  GluonPlayer.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonPlayer : Player {
    public typealias TargetLocation = GluonLocation
    public typealias TargetPotionEffect = GluonPotionEffect
    
    public let connection:PlayerConnection
    
    public var name:String
    public var list_name:String?
    
    public var experience:UInt64
    public var experience_level:UInt64
    public var food_level:UInt64
    
    public var permissions:Set<String>
    public var statistics:Set<StatisticActive>
    
    public var game_mode:GameMode
    
    public var is_blocking:Bool
    public var is_flying:Bool
    public var is_op:Bool
    public var is_sneaking:Bool
    public var is_sprinting:Bool
    
    public var inventory:any PlayerInventory
    
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
        return GluonServer.get_entities(uuids: passenger_uuids)
    }
    
    public var vehicle_uuid:UUID?
    public var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    public init(
        uuid: UUID,
        type: EntityType,
        ticks_lived: UInt64,
        custom_name: String?,
        display_name: String?,
        boundaries: [Boundary],
        location: TargetLocation,
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
        vehicle_uuid: UUID?
    ) {
        self.uuid = uuid
        self.type = type
        self.ticks_lived = ticks_lived
        self.custom_name = custom_name
        self.display_name = display_name
        self.boundaries = boundaries
        self.location = location
        self.fall_distance = fall_distance
        self.is_glowing = is_glowing
        self.is_on_fire = is_on_fire
        self.is_on_ground = is_on_ground
        self.fire_ticks = fire_ticks
        self.fire_ticks_maximum = fire_ticks_maximum
        self.freeze_ticks = freeze_ticks
        self.freeze_ticks_maximum = freeze_ticks_maximum
        self.passenger_uuids = passenger_uuids
        self.vehicle_uuid = vehicle_uuid
    }
    
    public mutating func tick(_ server: any Server) {
        tick_player(server)
    }
    
    public func save() {
    }
    
}
