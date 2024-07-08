//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Block : BlockBehavior, Tickable {
    var materialID : String { get }
    var material : Material? { get }
    
    var requires_correct_tool_for_drops : Bool { get }
    var hasCollision : Bool { get }
    
    var instrument : Instrument? { get }
    
    var mapColor : Color? { get }
    var stepSound : Sound? { get }
    
    var lightLevel : UInt8 { get set }
    var location : any Location { get set }
    
    var growable_age : UInt8? { get set }
    
    var loot_table : LootTable? { get set }
    
    func breakNaturally()
    
    func isPreferredTool(_ material: Material) -> Bool
    /// Measured in ticks.
    func getBreakingSpeed(_ item_stack: ItemStack) -> Float
    /// Measured in ticks.
    func getBreakingSpeed(_ player: any Player) -> Float
}

public extension Block {
    var isFullyGrown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable?.maximum_age ?? 0
    }
    
    func isPreferredTool(_ material: Material) -> Bool {
        let identifier:String = material.id
        return self.material?.configuration.block?.preferred_break_material_identifiers?.contains(identifier) ?? false
    }
}

public extension Block {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        // TODO: fix?
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        // TODO: fix?
    }
}
