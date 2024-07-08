//
//  GluonLivingEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

/*
final class GluonLivingEntity : LivingEntity {
    var can_breathe_underwater:Bool
    var can_pickup_items:Bool
    var has_ai:Bool
    
    var is_climbing:Bool
    var is_collidable:Bool
    var is_gliding:Bool
    var is_invisible:Bool
    var is_leashed:Bool
    var is_riptiding:Bool
    var is_sleeping:Bool
    var is_swimming:Bool
    
    var potion_effects:[String:any PotionEffect]
    var no_damage_ticks:UInt16
    var no_damage_ticks_maximum:UInt16
    
    var air_remaining_ticks:UInt16
    var air_maximum_ticks:UInt16
    
    var health:Double
    var health_maximum:Double
    
    var id:UInt64
    var uuid:UUID
    var typeID:String
    var type : (EntityType)? {
        return GluonServer.shared.get_entity_type(identifier: type_id)
    }
    var ticks_lived:UInt64
    let name:String
    var customName:String?
    var displayName:String?
    
    var boundaries:[Boundary]
    var location:any Location
    var velocity:Vector
    
    var fall_distance:Float
    
    var is_glowing:Bool
    var is_on_fire:Bool
    var is_on_ground:Bool
    
    var height:Float
    
    var fire_ticks:UInt16
    var fire_ticks_maximum:UInt16
    var freeze_ticks:UInt16
    var freeze_ticks_maximum:UInt16
    
    var passenger_uuids:Set<UUID>
    var passengers : [any Entity] {
        return GluonServer.shared.get_entities(uuids: passenger_uuids)
    }
    
    var vehicle_uuid:UUID?
    var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared.get_entity(uuid: uuid)
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
        potion_effects: [String : any PotionEffect],
        no_damage_ticks: UInt16,
        no_damage_ticks_maximum: UInt16,
        air_remaining: UInt16,
        air_maximum: UInt16,
        health: Double,
        health_maximum: Double,
        id: UInt64,
        uuid: UUID,
        type_id: String,
        ticks_lived: UInt64,
        name: String,
        customName: String? = nil,
        displayName: String? = nil,
        boundaries: [Boundary],
        location: any Location,
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
        self.potion_effects = potion_effects
        self.no_damage_ticks = no_damage_ticks
        self.no_damage_ticks_maximum = no_damage_ticks_maximum
        self.air_remaining_ticks = air_remaining
        self.air_maximum_ticks = air_maximum
        self.health = health
        self.health_maximum = health_maximum
        self.id = id
        self.uuid = uuid
        self.type_id = type_id
        self.ticks_lived = ticks_lived
        self.name = name
        self.customName = customName
        self.displayName = displayName
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
    
    /*
    init(from decoder: Decoder) throws {
        let living_entity_container:KeyedDecodingContainer = try decoder.container(keyedBy: LivingEntityCodingKeys.self)
        self.can_breathe_underwater = try living_entity_container.decode(Bool.self, forKey: .can_breathe_underwater)
        self.can_pickup_items = try living_entity_container.decode(Bool.self, forKey: .can_pickup_items)
        self.has_ai = try living_entity_container.decode(Bool.self, forKey: .has_ai)
        self.is_climbing = try living_entity_container.decode(Bool.self, forKey: .is_climbing)
        self.is_collidable = try living_entity_container.decode(Bool.self, forKey: .is_collidable)
        self.is_gliding = try living_entity_container.decode(Bool.self, forKey: .is_gliding)
        self.is_invisible = try living_entity_container.decode(Bool.self, forKey: .is_invisible)
        self.is_leashed = try living_entity_container.decode(Bool.self, forKey: .is_leashed)
        self.is_riptiding = try living_entity_container.decode(Bool.self, forKey: .is_riptiding)
        self.is_sleeping = try living_entity_container.decode(Bool.self, forKey: .is_sleeping)
        self.is_swimming = try living_entity_container.decode(Bool.self, forKey: .is_swimming)
        self.potion_effects = try living_entity_container.decode([String : GluonPotionEffect].self, forKey: .potion_effects)
        self.no_damage_ticks = try living_entity_container.decode(UInt16.self, forKey: .no_damage_ticks)
        self.no_damage_ticks_maximum = try living_entity_container.decode(UInt16.self, forKey: .no_damage_ticks_maximum)
        self.air_remaining = try living_entity_container.decode(UInt16.self, forKey: .air_remaining)
        self.air_maximum = try living_entity_container.decode(UInt16.self, forKey: .air_maximum)
        
        let damageable_container:KeyedDecodingContainer = try decoder.container(keyedBy: DamageableCodingKeys.self)
        self.health = try damageable_container.decode(Double.self, forKey: .health)
        self.health_maximum = try damageable_container.decode(Double.self, forKey: .health_maximum)
        
        let entity_container:KeyedDecodingContainer = try decoder.container(keyedBy: EntityCodingKeys.self)
        self.uuid = try entity_container.decode(UUID.self, forKey: .uuid)
        let type_identifier:String = try entity_container.decode(String.self, forKey: .type)
        self.type = GluonServer.shared.get_entity_type(identifier: type_identifier)!
        self.ticks_lived = try entity_container.decode(UInt64.self, forKey: .ticks_lived)
        self.customName = try entity_container.decodeIfPresent(String.self, forKey: .customName)
        self.displayName = try entity_container.decodeIfPresent(String.self, forKey: .displayName)
        self.boundaries = try entity_container.decode([Boundary].self, forKey: .boundaries)
        self.location = try entity_container.decode(TargetLocation.self, forKey: .location)
        self.velocity = try entity_container.decode(Vector.self, forKey: .velocity)
        self.fall_distance = try entity_container.decode(Float.self, forKey: .fall_distance)
        self.is_glowing = try entity_container.decode(Bool.self, forKey: .is_glowing)
        self.is_on_fire = try entity_container.decode(Bool.self, forKey: .is_on_fire)
        self.is_on_ground = try entity_container.decode(Bool.self, forKey: .is_on_ground)
        self.height = try entity_container.decode(Float.self, forKey: .height)
        self.fire_ticks = try entity_container.decode(UInt16.self, forKey: .fire_ticks)
        self.fire_ticks_maximum = try entity_container.decode(UInt16.self, forKey: .fire_ticks_maximum)
        self.freeze_ticks = try entity_container.decode(UInt16.self, forKey: .freeze_ticks)
        self.freeze_ticks_maximum = try entity_container.decode(UInt16.self, forKey: .freeze_ticks_maximum)
        self.passenger_uuids = try entity_container.decode(Set<UUID>.self, forKey: .passenger_uuids)
        self.vehicle_uuid = try entity_container.decodeIfPresent(UUID.self, forKey: .vehicle_uuid)
    }*/
}
*/
