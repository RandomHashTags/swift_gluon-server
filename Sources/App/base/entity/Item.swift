//
//  Item.swift
//  
//
//  Created by Evan Anderson on 2/16/23.
//

import Foundation

public protocol Item : Entity {
    var item_stack : ItemStack { get set }
    var pickup_delay : UInt8 { get set }
}
public extension Item {
    mutating func tick(_ server: GluonServer) {
        tick_entity(server)
        
        if fire_ticks > 0 || ticks_lived >= UInt64(server.ticks_per_second) * 60 * 5 {
            remove()
            return
        }
    }
}
