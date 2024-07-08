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
    var typeID : String { get }
    var type : EntityType? { get }
    
    var ticks_lived : UInt64 { get set }
    
    var boundaries : [Boundary] { get set }
    /// The current location of this entity.
    var location : any Location { get set }
    /// The current velocity of this entity.
    var velocity : Vector { get set }
    /// The total fall distance of this entity, measured in blocks.
    var fallDistance : Float { get set }
    
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
        
    func tick_entity(_ server: any Server)
    
    /// Removes this entity from the server. Like it never existed (or "despawned").
    func remove()
    
    /// Teleport this entity to a certain location.
    func teleport(_ location: any Location)
}

public extension Entity {
    static func == (lhs: any Entity, rhs: any Entity) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.typeID == rhs.typeID
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.typeID == rhs.typeID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(typeID)
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
        
        if let type:EntityType = type, type.isAffectedByGravity && !is_on_ground {
            let new_location:Double = location.y - server.gravity_per_tick
            // TODO: check distance to closest block at Y position
            location.y = new_location
        }
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
    case customName
    case displayName
    case boundaries
    case location
    case velocity
    case fallDistance
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
