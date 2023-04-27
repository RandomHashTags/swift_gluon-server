//
//  GluonLivingEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

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
    
    mutating func tick(_ server: any Server) {
        tick_living_entity(server)
    }
}
