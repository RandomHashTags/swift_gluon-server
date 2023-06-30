//
//  MaterialItemConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialItemConfiguration {
    /// Maximum amount of the same item that can be stacked in one slot.
    var item_stack_size_maximum : Int { get }
    
    /// If the item has durability.
    var has_durability : Bool { get }
    /// The item's maximum durability.
    var durability : UInt { get }
    
    var consumable : (any MaterialItemConsumableConfiguration)? { get }
    
    /// Amount of health points this item inflicts to a ``LivingEntity``.
    var attack_damage : Double { get }
    /// Amount of durability to reduced this item by when attacking a ``LivingEntity``.
    var attack_durability_damage : UInt { get }
    /// Amount of durability to reduce an item of the material by if the block broken does prefer the item's material.
    var break_preferred_block_durability_damage : UInt { get }
    /// Amount of durability to reduce an item of this material by if the block broken doesn't prefer the item's material.
    var break_nonpreferred_block_durability_damage : UInt { get }
    
    /// The material identifiers this item can only be placed on.
    var place_block_whitelist : Set<String>? { get }
    /// The material identifiers this item cannot be placed on.
    var place_block_blacklist : Set<String>? { get }
}
