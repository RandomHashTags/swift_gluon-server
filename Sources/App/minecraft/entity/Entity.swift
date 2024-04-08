//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Entity : AnyObject, Hashable, Nameable, Tickable {
    var id : UInt64 { get }
    var uuid : UUID { get }
    /// the ``EntityType`` id
    var type_id : String { get }
    var type : (any EntityType)? { get }
    
    var ticks_lived : UInt64 { get set }
    
    var boundaries : [Boundary] { get set }
    /// The current location of this entity.
    var location : any Location { get set }
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
    
    func tick_entity(_ server: any Server)
    
    /// Removes this entity from the server. Like it never existed (or "despawned").
    func remove()
    
    /// Teleport this entity to a certain location.
    func teleport(_ location: any Location)
}

public extension Entity {
    static func == (lhs: any Entity, rhs: any Entity) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.type_id == rhs.type_id
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.type_id == rhs.type_id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(type_id)
    }
    
    func tick(_ server: any Server) {
        tick_entity(server)
    }
    func tick_entity(_ server: any Server) {
        default_tick_entity(server)
    }
    func default_tick_entity(_ server: any Server) {
        ServerMojang.instance.logger.info("Entity;default_tick_entity;entity with uuid \(uuid) has been ticked")
        ticks_lived += 1
        
        if let type:any EntityType = type, type.is_affected_by_gravity && !is_on_ground {
            let new_location:Double = location.y - server.gravity_per_tick
            // TODO: check distance to closest block at Y position
            location.y = new_location
        }
    }
    
    var entity_executable_context : [String:ExecutableLogicalContext] {
        return [
            "entity_type" : ExecutableLogicalContext(value_type: .string, value: type_id),
            
            "is_on_fire" : ExecutableLogicalContext(value_type: .boolean, value: is_on_fire),
            "is_on_ground" : ExecutableLogicalContext(value_type: .boolean, value: is_on_ground),
            
            "ticks_lived" : ExecutableLogicalContext(value_type: .long_unsigned, value: ticks_lived)
        ]
    }
    
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        fire_ticks /= divisor
        fire_ticks_maximum /= divisor
        
        freeze_ticks /= divisor
        freeze_ticks_maximum /= divisor
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        fire_ticks *= multiplier
        fire_ticks_maximum *= multiplier
        
        freeze_ticks *= multiplier
        freeze_ticks_maximum *= multiplier
    }
}

public enum EntityCodingKeys : CodingKey {
    case uuid
    case type_id
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
