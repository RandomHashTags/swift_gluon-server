//
//  GluonItem.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonItem : Item {
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
    
    mutating func tick(_ server: any Server) {
        tick_item(server)
    }
}
