//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import HugeNumbers

public protocol Entity : Nameable, Tickable, Saveable {
    associatedtype TargetLocation : Location
    
    var uuid : UUID { get }
    var type : EntityType { get }
    var ticks_lived : UInt64 { get set }
    var custom_name : String? { get set }
    var display_name : String? { get set }
    
    var boundaries : [Boundary] { get set }
    /// The current location of this entity.
    var location : TargetLocation { get set }
    /// The current velocity of this entity.
    var velocity : Vector { get set }
    /// The total fall distance of this entity, measured in blocks.
    var fall_distance : Float { get set }
    
    var is_glowing : Bool { get set }
    var is_on_fire : Bool { get set }
    var is_on_ground : Bool { get set }
    
    var height : Float { get set }
    
    var fire_ticks : UInt16 { get set }
    var fire_ticks_maximum : UInt16 { get set }
    
    var freeze_ticks : UInt16 { get set }
    var freeze_ticks_maximum : UInt16 { get set }
    
    /// The UUIDs of the entities currently riding this entity.
    var passenger_uuids : Set<UUID> { get set }
    var passengers : [any Entity] { get }
    
    /// The vehicle UUID this entity is currently riding.
    var vehicle_uuid : UUID? { get set }
    var vehicle : (any Entity)? { get }
    
    var entity_executable_context : [String:ExecutableLogicalContext] { get }
    
    mutating func tick_entity(_ server: any Server)
    
    /// Removes this entity from the server. Like it never existed (or "despawned").
    mutating func remove()
    
    /// Teleport this entity to a certain location.
    mutating func teleport(_ location: TargetLocation)
}

public extension Entity {
    static func == (lhs: any Entity, rhs: any Entity) -> Bool {
        return lhs.uuid.uuidString.elementsEqual(rhs.uuid.uuidString) && lhs.type == rhs.type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(type)
    }
    
    mutating func tick(_ server: any Server) {
        tick_entity(server)
    }
    mutating func tick_entity(_ server: any Server) {
        default_tick_entity(server)
    }
    mutating func default_tick_entity(_ server: any Server) {
        print("entity with uuid " + uuid.description + " has been ticked")
        ticks_lived += 1
        
        if type.is_affected_by_gravity && !is_on_ground {
            var new_location:HugeFloat = location.y - server.gravity_per_tick
            // TODO: check distance to closest block at Y position
            location.y = new_location
        }
    }
    
    var entity_executable_context : [String:ExecutableLogicalContext] {
        return [
            "entity_type" : ExecutableLogicalContext(value_type: .string, value: type.identifier),
            
            "is_on_fire" : ExecutableLogicalContext(value_type: .boolean, value: is_on_fire),
            "is_on_ground" : ExecutableLogicalContext(value_type: .boolean, value: is_on_ground),
            
            "ticks_lived" : ExecutableLogicalContext(value_type: .long_unsigned, value: ticks_lived)
        ]
    }
}

public enum EntityCodingKeys : CodingKey {
    case uuid
    case type
    case ticks_lived
    case custom_name
    case display_name
    case boundaries
    case location
    case velocity
    case fall_distance
    case is_glowing
    case is_on_fire
    case is_on_ground
    case height
    case fire_ticks
    case fire_ticks_maximum
    case freeze_ticks
    case freeze_ticks_maximum
    case passenger_uuids
    case vehicle_uuid
}
