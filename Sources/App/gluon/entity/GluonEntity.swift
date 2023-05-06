//
//  GluonEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

struct GluonEntity : Entity {
    typealias TargetLocation = GluonLocation
    
    let uuid:UUID
    let type:EntityType
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
        tick_entity(server)
    }
}

extension Entity {
    func remove() {
        GluonServer.shared_instance.worlds[location.world_name]?.remove_entity(self as! GluonWorld.TargetEntity)
    }
    mutating func teleport(_ location: TargetLocation) {
        let event:GluonEntityTeleportEvent = GluonEntityTeleportEvent(entity: self, new_location: location)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.location = location
    }
}
