//
//  GluonItem.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

final class GluonItem : Item {
    var uuid:UUID
    var type_id:String
    var type : (any EntityType)? {
        return GluonServer.shared_instance.get_entity_type(identifier: type_id)
    }
    var ticks_lived:UInt64
    var custom_name:String?
    var display_name:String?
    
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
        return GluonServer.shared_instance.get_entities(uuids: passenger_uuids)
    }
    var vehicle_uuid:UUID?
    var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    var item_stack:any ItemStack
    var pickup_delay:UInt8
    
    init(uuid: UUID, type_id: String, ticks_lived: UInt64, custom_name: String? = nil, display_name: String? = nil, boundaries: [Boundary], location: any Location, velocity: Vector, fall_distance: Float, is_glowing: Bool, is_on_fire: Bool, is_on_ground: Bool, height: Float, fire_ticks: UInt16, fire_ticks_maximum: UInt16, freeze_ticks: UInt16, freeze_ticks_maximum: UInt16, passenger_uuids: Set<UUID>, vehicle_uuid: UUID? = nil, item_stack: any ItemStack, pickup_delay: UInt8) {
        self.uuid = uuid
        self.type_id = type_id
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
        self.item_stack = item_stack
        self.pickup_delay = pickup_delay
    }
    
    func tick(_ server: any Server) {
        tick_item(server)
    }
}
