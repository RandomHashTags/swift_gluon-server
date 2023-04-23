//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Block : Jsonable, Tickable, Saveable {
    associatedtype TargetLocation : Location
    
    var material_identifier : String { get set }
    var material : Material? { get }
    var light_level : UInt8 { get set }
    var location : TargetLocation { get set }
    
    var growable_age : UInt8? { get set }
    
    var loot_table : LootTable? { get set }
    
    func break_naturally()
    func is_preferred_tool(_ material: Material) -> Bool
    /// Measured in ticks.
    func get_breaking_speed(_ item_stack: ItemStack) -> Float
    /// Measured in ticks.
    func get_breaking_speed(_ player: any Player) -> Float
}

public extension Block {
    var is_fully_grown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable?.maximum_age ?? 0
    }
    
    func is_preferred_tool(_ material: Material) -> Bool {
        return self.material?.configuration.block?.preferred_break_materials?.contains(material) ?? false
    }
}
