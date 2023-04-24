//
//  GluonMaterialItemConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonMaterialItemConfiguration : MaterialItemConfiguration {
    public let item_stack_size_maximum:Int
    
    public let has_durability:Bool
    public let durability:UInt
    
    public let consumable:MaterialItemConsumableConfiguration?
    
    public let attack_damage:Double
    public let attack_durability_damage:UInt
    public let break_preferred_block_durability_damage:UInt
    public let break_nonpreferred_block_durability_damage:UInt
    
    public let place_block_whitelist:Set<String>?
    public let place_block_blacklist:Set<String>?
}
