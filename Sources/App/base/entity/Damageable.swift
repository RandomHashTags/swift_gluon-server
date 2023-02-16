//
//  Damageable.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Damageable : Entity {
    public var health:Double
    public var health_maximum:Double
    
    public init(
        uuid: UUID,
        type: EntityType,
        custom_name: String?,
        display_name: String?,
        health: Double,
        health_maximum: Double
    ) {
        self.health = health
        self.health_maximum = health_maximum
        super.init(
            uuid: uuid,
            type: type,
            custom_name: custom_name,
            display_name: display_name,
            boundaries: [],
            location: Location(world_name: "overworld", x: 0, y: 0, z: 0, yaw: 0, pitch: 0),
            velocity: Vector(x: 0, y: 0, z: 0),
            fall_distance: 0,
            is_glowing: false,
            is_on_fire: false,
            is_on_ground: true,
            height: 10,
            fire_ticks: 0,
            fire_ticks_maximum: 20,
            freeze_ticks: 0,
            freeze_ticks_maximum: 20,
            passenger_uuids: [],
            vehicle_uuid: nil
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
        try super.init(from: decoder)
    }
    
    public override func tick(_ server: GluonServer) {
        print("damageable with uuid " + uuid.uuidString + " has been ticked")
        fire_ticks = fire_ticks == 0 ? 0 : fire_ticks - 1
        super.tick(server)
    }
    
    public func damage(cause: DamageCause, amount: Double) -> DamageResult {
        let new_health:Double = max(0, health - amount)
        let event:EntityDamageEvent = EntityDamageEvent(entity: self, cause: cause, amount: amount)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else {
            return DamageResult.failure(.cancelled)
        }
        health = new_health
        guard health == 0 else {
            // TODO: finish
            return DamageResult.success(.killed)
        }
        return DamageResult.success(.normal)
    }
}
