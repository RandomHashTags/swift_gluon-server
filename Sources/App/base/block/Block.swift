//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Block : Jsonable, Tickable, Saveable {
    associatedtype TargetMaterial : Material
    associatedtype TargetItemStack : ItemStack
    associatedtype TargetLocation : Location
    associatedtype TargetLootTable : LootTable
    
    var material_identifier : String { get set }
    var material : TargetMaterial? { get }
    var light_level : UInt8 { get set }
    var location : TargetLocation { get set }
    
    var growable_age : UInt8? { get set }
    
    var loot_table : TargetLootTable? { get set }
    
    func break_naturally()
    func is_preferred_tool(_ material: TargetMaterial) -> Bool
    /// Measured in ticks.
    func get_breaking_speed(_ item_stack: TargetItemStack) -> Float
    /// Measured in ticks.
    func get_breaking_speed(_ player: any Player) -> Float
}

public extension Block {
    var is_fully_grown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable?.maximum_age ?? 0
    }
    
    func is_preferred_tool(_ material: TargetMaterial) -> Bool {
        let identifier:String = material.identifier
        return self.material?.configuration.block?.preferred_break_material_identifiers?.contains(identifier) ?? false
    }
}
