//
//  Item.swift
//  
//
//  Created by Evan Anderson on 2/16/23.
//

import Foundation

public class Item : Entity {
    public var item_stack:ItemStack
    public var pickup_delay:UInt8
    
    public init(
        item_stack: ItemStack,
        pickup_delay: UInt8,
        location: Location
    ) {
        self.item_stack = item_stack
        self.pickup_delay = pickup_delay
        super.init(
            uuid: UUID(),
            type: GluonServer.get_entity_type(identifier: "minecraft.item")!,
            ticks_lived: 0,
            custom_name: nil,
            display_name: nil,
            boundaries: [],
            location: location,
            velocity: Vector(x: 0, y: 0, z: 0),
            fall_distance: 0,
            is_glowing: false,
            is_on_fire: false,
            is_on_ground: false,
            height: 0.25,
            fire_ticks: 0,
            fire_ticks_maximum: 1,
            freeze_ticks: 0,
            freeze_ticks_maximum: 0,
            passenger_uuids: [],
            vehicle_uuid: nil
        )
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    
    public override func tick(_ server: GluonServer) {
        super.tick(server)
        
        if fire_ticks > 0 || ticks_lived >= UInt64(server.ticks_per_second) * 60 * 5 {
            remove()
            return
        }
    }
}
