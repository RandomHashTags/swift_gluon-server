//
//  Damageable.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Damageable : Entity {
    public var health:Float
    public var health_maximum:Float
    
    public init(
        uuid: UUID,
        type: EntityType,
        custom_name: String?,
        display_name: String?,
        health: Float,
        health_maximum: Float
    ) {
        self.health = health
        self.health_maximum = health_maximum
        super.init(
            uuid: uuid,
            type: type,
            custom_name: custom_name,
            display_name: display_name,
            boundaries: [],
            location: Location(world_name: "world", x: 0, y: 0, z: 0, yaw: 0, pitch: 0),
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
    
    override func tick() {
        print("damageable with uuid " + uuid.uuidString + " has been ticked")
        fire_ticks = fire_ticks == 0 ? 0 : fire_ticks - 1
        super.tick()
    }
    
    public func damage(amount: Float) -> DamageResult {
        let new_health:Float = max(0, health - amount)
        health = new_health
        if new_health == 0 {
            // TODO: finish
            return DamageResult.success(.killed)
        }
        return DamageResult.success(.normal)
    }
}
