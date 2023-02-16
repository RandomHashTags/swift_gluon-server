//
//  MaterialItemConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct MaterialItemConfiguration : Jsonable {
    /// Maximum amount of the same item that can be stacked in one slot.
    public let item_stack_size_maximum:Int
    
    /// If the item has durability.
    public let has_durability:Bool
    /// The item's maximum durability.
    public let durability:Int
    
    /// Amount of health points this item inflicts to a LivingEntity.
    public let attack_damage:Double
    /// Amount of durability to reduced this item by when attacking a LivingEntity.
    public let attack_durability_damage:UInt
    /// Amount of durability to reduce this item by if the block broken does prefer the item's material.
    public let break_preferred_block_durability_damage:UInt
    /// Amount of durability to reduce this item by if the block broken doesn't prefer the item's material.
    public let break_nonpreferred_block_durability_damage:UInt
    
    public let place_block_whitelist:Set<String>?
    public let place_block_blacklist:Set<String>?
}
