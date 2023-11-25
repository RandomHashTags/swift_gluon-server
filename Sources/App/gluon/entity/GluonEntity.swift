//
//  GluonEntity.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

final class GluonEntity : Entity {
    let id:UInt64
    let uuid:UUID
    let type_id:String
    var type : (any EntityType)? {
        return GluonServer.shared_instance.get_entity_type(identifier: type_id)
    }
    var ticks_lived:UInt64
    let name:String
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
    
    func tick(_ server: any Server) {
        tick_entity(server)
    }
    
    init(id: UInt64, uuid: UUID, type_id: String, ticks_lived: UInt64, name: String, custom_name: String? = nil, display_name: String? = nil, boundaries: [Boundary], location: any Location, velocity: Vector, fall_distance: Float, is_glowing: Bool, is_on_fire: Bool, is_on_ground: Bool, height: Float, fire_ticks: UInt16, fire_ticks_maximum: UInt16, freeze_ticks: UInt16, freeze_ticks_maximum: UInt16, passenger_uuids: Set<UUID>, vehicle_uuid: UUID? = nil) {
        self.id = id
        self.uuid = uuid
        self.type_id = type_id
        self.ticks_lived = ticks_lived
        self.name = name
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
    
    /*init(from decoder: Decoder) throws {
        let container:KeyedDecodingContainer = try decoder.container(keyedBy: EntityCodingKeys.self)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        let type_identifier:String = try container.decode(String.self, forKey: .type)
        self.type = GluonServer.shared_instance.get_entity_type(identifier: type_identifier)!
        self.ticks_lived = try container.decode(UInt64.self, forKey: .ticks_lived)
        self.custom_name = try container.decodeIfPresent(String.self, forKey: .custom_name)
        self.display_name = try container.decodeIfPresent(String.self, forKey: .display_name)
        self.boundaries = try container.decode([Boundary].self, forKey: .boundaries)
        self.location = try container.decode(GluonEntity.TargetLocation.self, forKey: .location)
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
    }*/
}

extension Entity {
    func remove() { // TODO: fix
    }
    func teleport(_ location: any Location) { // TODO: fix
    }
}

extension GluonEntity {
    func remove() {
        location.world.remove_entity(self)
    }
    func teleport(_ location: any Location) {
        let event:GluonEntityTeleportEvent = GluonEntityTeleportEvent(entity: self, new_location: location)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.location = location
    }
}
