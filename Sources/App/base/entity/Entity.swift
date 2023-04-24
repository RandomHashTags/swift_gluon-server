//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

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
    /// The current velocity this entity is experiencing.
    var velocity : Vector { get set }
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
    
    init(
        uuid: UUID,
        type: EntityType,
        ticks_lived: UInt64,
        custom_name: String?,
        display_name: String?,
        boundaries: [Boundary],
        location: TargetLocation,
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
        vehicle_uuid: UUID?
    )
    
    mutating func tick_entity(_ server: any Server)
    
    /// Removes this entity from the server. Like it never existed (or "despawned").
    func remove()
    
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
    
    mutating func tick_entity(_ server: any Server) {
        ticks_lived += 1
        
        if type.is_affected_by_gravity && !is_on_ground {
            location.y -= server.gravity_per_tick
        }
        
        if type.is_damageable, let world:any World = location.world {
            let y:HugeFloat = location.y
            
            if y < world.y_min {
                
                let result:DamageResult = (self as! (any Damageable)).damage_damageable(cause: DamageCause.void, amount: server.void_damage_per_tick)
            }
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
    
    func remove() {
        location.world?.remove_entity(self)
    }
    
    mutating func teleport(_ location: TargetLocation) {
        let event:EntityTeleportEvent = EntityTeleportEvent(entity: self, new_location: location)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.location = location
    }
}
