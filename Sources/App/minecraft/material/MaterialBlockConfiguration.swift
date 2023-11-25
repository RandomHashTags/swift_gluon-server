//
//  MaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialBlockConfiguration {
    /// The reaction of this block when moved via in-game mechanics.
    var block_move_reaction : BlockMoveReaction { get }
    
    /// The growing configuration of this block, if it grows.
    var growable : MaterialBlockGrowableConfiguration? { get }
    
    /// The liquid configuration of this block, if it is a liquid.
    var liquid : (any MaterialBlockLiquidConfiguration)? { get }
    
    /// If entities can passthrough (walk/sprint/swim through) this block or not.
    var can_passthrough : Bool { get }
    var passthrough_velocity_dampen_x : Float { get }
    var passthrough_velocity_dampen_y : Float { get }
    var passthrough_velocity_dampen_z : Float { get }
    
    /// Whether an Entity receives fall damage when falling on this block or not.
    var breaks_fall : Bool { get }
    
    var resistance : Int { get }
    var hardness : Float { get }
    var preferred_break_material_identifiers : Set<String>? { get }
    var preferred_break_materials : [any Material]? { get }
    
    /// The items that can be dropped when this block is broken.
    var loot : (any LootTable)? { get }
}
