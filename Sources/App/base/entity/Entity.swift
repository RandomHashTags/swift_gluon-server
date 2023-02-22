//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Entity : Nameable, Tickable {
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.uuid.uuidString.elementsEqual(rhs.uuid.uuidString) && lhs.type == rhs.type
    }
    
    public let uuid:UUID
    public let type:EntityType
    public private(set) var ticks_lived:UInt64
    public var custom_name:String?
    public var display_name:String?
    
    public var boundaries:[Boundary]
    public var location:Location
    public var velocity:Vector
    public var fall_distance:Float
    
    public var is_glowing:Bool
    public var is_on_fire:Bool
    public var is_on_ground:Bool
    
    public var height:Float
    
    public var fire_ticks:UInt16
    public var fire_ticks_maximum:UInt16
    
    public var freeze_ticks:UInt16
    public var freeze_ticks_maximum:UInt16
    
    public var passenger_uuids:Set<UUID>
    public var passengers : [Entity] {
        return GluonServer.get_entities(uuids: passenger_uuids)
    }
    public var vehicle_uuid:UUID?
    public var vehicle : Entity? {
        return vehicle_uuid != nil ? GluonServer.get_entity(uuid: vehicle_uuid!) : nil
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(type)
    }
    
    public init(
        uuid: UUID,
        type: EntityType,
        ticks_lived: UInt64,
        custom_name: String?,
        display_name: String?,
        boundaries: [Boundary],
        location: Location,
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
    ) {
        self.uuid = uuid
        self.type = type
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
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    func save() {
    }
    func tick(_ server: GluonServer) {
        ticks_lived += 1
        
        if type.is_affected_by_gravity && !is_on_ground {
            location.y -= server.gravity_per_tick
        }
        
        if type.is_damageable, let world:World = location.world {
            let y:Double = location.y
            
            if y < Double(world.y_min) {
                let result:DamageResult = (self as! Damageable).damage(cause: DamageCause.void, amount: server.void_damage_per_tick)
            }
        }
        
    }
    
    /// Removes this entity from the server. Like it never existed (or "despawned").
    public func remove() {
        location.world?.remove_entity(self)
    }
    
    public func get_nearby_entities(x: Double, y: Double, z: Double) -> Set<Entity> {
        return []
    }
    
    public func teleport(location: Location) {
        let event:EntityTeleportEvent = EntityTeleportEvent(entity: self, new_location: location)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.location = location
    }
}
