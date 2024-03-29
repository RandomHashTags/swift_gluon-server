//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Block : BlockBehavior, Tickable {
    associatedtype InstrumentType : Instrument
    
    var material_id : String { get }
    var material : (any Material)? { get }
    
    var requires_correct_tool_for_drops : Bool { get }
    var has_collision : Bool { get }
    
    var instrument : InstrumentType? { get }
    
    var map_color : Color? { get }
    var step_sound : (any Sound)? { get }
    
    var light_level : UInt8 { get set }
    var location : any Location { get set }
    
    var growable_age : UInt8? { get set }
    
    var loot_table : (any LootTable)? { get set }
    
    func break_naturally()
    
    func is_preferred_tool(_ material: any Material) -> Bool
    /// Measured in ticks.
    func get_breaking_speed(_ item_stack: any ItemStack) -> Float
    /// Measured in ticks.
    func get_breaking_speed(_ player: any Player) -> Float
}

public extension Block {
    var is_fully_grown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable?.maximum_age ?? 0
    }
    
    func is_preferred_tool(_ material: any Material) -> Bool {
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
