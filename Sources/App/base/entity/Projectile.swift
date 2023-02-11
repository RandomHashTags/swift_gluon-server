//
//  Projectile.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class Projectile : Entity {
    public let source:ProjectileSource?
    
    public init(
        uuid: UUID,
        type: EntityType,
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
        vehicle_uuid: UUID?,
        source: ProjectileSource
    ) {
        self.source = source
        super.init(
            uuid: uuid,
            type: type,
            custom_name: custom_name,
            display_name: display_name,
            boundaries: boundaries,
            location: location,
            velocity: velocity,
            fall_distance: fall_distance,
            is_glowing: is_glowing,
            is_on_fire: is_on_fire,
            is_on_ground: is_on_ground,
            height: height,
            fire_ticks: fire_ticks,
            fire_ticks_maximum: fire_ticks_maximum,
            freeze_ticks: freeze_ticks,
            freeze_ticks_maximum: freeze_ticks_maximum,
            passenger_uuids: passenger_uuids,
            vehicle_uuid: vehicle_uuid
        )
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
