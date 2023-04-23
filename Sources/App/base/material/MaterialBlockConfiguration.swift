//
//  MaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct MaterialBlockConfiguration : Jsonable {
    public let type:BlockType
    
    /// The reaction of this block when moved via in-game mechanics.
    public let block_move_reaction:BlockMoveReaction
    
    /// The growing configuration of this block, if it grows.
    public let growable:MaterialBlockGrowableConfiguration?
    
    /// The liquid configuration of this block, if it is a liquid.
    public let liquid:MaterialBlockLiquidConfiguration?
    
    /// If entities can passthrough (walk/sprint/swim through) this block or not.
    public let can_passthrough:Bool
    public let passthrough_velocity_dampen_x:Float
    public let passthrough_velocity_dampen_y:Float
    public let passthrough_velocity_dampen_z:Float
    
    /// Whether an Entity receives fall damage when falling on this block or not.
    public let breaks_fall:Bool
    
    /// If this block breaks instantly when punched.
    public let breaks_instantly:Bool
    public let resistance:Int
    public let hardness:Float
    public let preferred_break_material_identifiers:Set<String>?
    
    /// The items that can be dropped when this block is broken.
    public let loot:LootTable?
}
public extension MaterialBlockConfiguration {
    var preferred_break_materials : Set<Material>? {
        guard let identifiers:Set<String> = preferred_break_material_identifiers else { return nil }
        return GluonServer.get_materials(identifiers: identifiers)
    }
}
