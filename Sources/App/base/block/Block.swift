//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct Block : Hashable {
    public var material_identifier:String
    public var material : Material? {
        return GluonServer.get_material(identifier: material_identifier)
    }
    
    public var light_level:UInt8
    public var location:Location
    
    public var growable_age:UInt8?
    public var is_fully_grown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable_configuration?.maximum_age ?? 0
    }
    
    public var loot_table:LootTable?
    
    public func break_naturally() {
        if let loot:[ItemStack] = loot_table?.loot_normal, let world:World = location.world {
            let pickup_delay:UInt8 = GluonServer.shared_instance.ticks_per_second/2
            let item_location:Location = location.advanced_by(x: 0.5, y: 0.5, z: 0.5)
            for item_stack in loot {
                let item:Item = Item(item_stack: item_stack, pickup_delay: pickup_delay, location: item_location)
                world.spawn_entity(item)
            }
        }
    }
}
