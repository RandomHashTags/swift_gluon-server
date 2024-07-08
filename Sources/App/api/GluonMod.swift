//
//  GluonMod.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol GluonMod {
    var team_id : String { get }
    var name : String { get }
    var authors : [String] { get }
    var version : SemanticVersion { get }
    
    func load() async throws
    func unload() async throws
    
    var custom_enchantment_types : [EnchantmentType] { get }
    var custom_entity_types : [EntityType] { get }
    var custom_inventory_types : [EnchantmentType] { get }
}

public extension GluonMod {
    var custom_enchantment_types:[EnchantmentType] { return [] }
    var custom_entity_types:[EntityType] { return [] }
    var custom_inventory_types:[EnchantmentType] { return [] }
}
