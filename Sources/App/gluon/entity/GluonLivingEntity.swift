//
//  GluonLivingEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

struct GluonLivingEntity : LivingEntity {
    typealias TargetPotionEffect = GluonPotionEffect
    typealias TargetLocation = GluonLocation
    
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
    
    var potion_effects:[String:GluonPotionEffect]
    var no_damage_ticks:UInt16
    var no_damage_ticks_maximum:UInt16
    
    var air_remaining:UInt16
    var air_maximum:UInt16
    
    var health:Double
    var health_maximum:Double
    
    var uuid:UUID
    var type:EntityType
    var ticks_lived:UInt64
    var custom_name:String?
    var display_name:String?
    
    var boundaries:[Boundary]
    var location:TargetLocation
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
        return GluonServer.shared_instance.get_entities(uuids: passenger_uuids)
    }
    
    var vehicle_uuid:UUID?
    var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.can_breathe_underwater = try container.decode(Bool.self, forKey: .can_breathe_underwater)
        self.can_pickup_items = try container.decode(Bool.self, forKey: .can_pickup_items)
        self.has_ai = try container.decode(Bool.self, forKey: .has_ai)
        self.is_climbing = try container.decode(Bool.self, forKey: .is_climbing)
        self.is_collidable = try container.decode(Bool.self, forKey: .is_collidable)
        self.is_gliding = try container.decode(Bool.self, forKey: .is_gliding)
        self.is_invisible = try container.decode(Bool.self, forKey: .is_invisible)
        self.is_leashed = try container.decode(Bool.self, forKey: .is_leashed)
        self.is_riptiding = try container.decode(Bool.self, forKey: .is_riptiding)
        self.is_sleeping = try container.decode(Bool.self, forKey: .is_sleeping)
        self.is_swimming = try container.decode(Bool.self, forKey: .is_swimming)
        self.potion_effects = try container.decode([String : GluonPotionEffect].self, forKey: .potion_effects)
        self.no_damage_ticks = try container.decode(UInt16.self, forKey: .no_damage_ticks)
        self.no_damage_ticks_maximum = try container.decode(UInt16.self, forKey: .no_damage_ticks_maximum)
        self.air_remaining = try container.decode(UInt16.self, forKey: .air_remaining)
        self.air_maximum = try container.decode(UInt16.self, forKey: .air_maximum)
        self.health = try container.decode(Double.self, forKey: .health)
        self.health_maximum = try container.decode(Double.self, forKey: .health_maximum)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        self.type = try container.decode(EntityType.self, forKey: .type)
        self.ticks_lived = try container.decode(UInt64.self, forKey: .ticks_lived)
        self.custom_name = try container.decodeIfPresent(String.self, forKey: .custom_name)
        self.display_name = try container.decodeIfPresent(String.self, forKey: .display_name)
        self.boundaries = try container.decode([Boundary].self, forKey: .boundaries)
        self.location = try container.decode(TargetLocation.self, forKey: .location)
        self.velocity = try container.decode(Vector.self, forKey: .velocity)
        self.fall_distance = try container.decode(Float.self, forKey: .fall_distance)
        self.is_glowing = try container.decode(Bool.self, forKey: .is_glowing)
        self.is_on_fire = try container.decode(Bool.self, forKey: .is_on_fire)
        self.is_on_ground = try container.decode(Bool.self, forKey: .is_on_ground)
        self.height = try container.decode(Float.self, forKey: .height)
        self.fire_ticks = try container.decode(UInt16.self, forKey: .fire_ticks)
        self.fire_ticks_maximum = try container.decode(UInt16.self, forKey: .fire_ticks_maximum)
        self.freeze_ticks = try container.decode(UInt16.self, forKey: .freeze_ticks)
        self.freeze_ticks_maximum = try container.decode(UInt16.self, forKey: .freeze_ticks_maximum)
        self.passenger_uuids = try container.decode(Set<UUID>.self, forKey: .passenger_uuids)
        self.vehicle_uuid = try container.decodeIfPresent(UUID.self, forKey: .vehicle_uuid)
    }
}
