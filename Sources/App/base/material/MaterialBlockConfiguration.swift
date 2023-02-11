//
//  MaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct MaterialBlockConfiguration : Jsonable {
    public let type:BlockType
    public let block_move_reaction:BlockMoveReaction
    /// If entities can passthrough (walk/sprint/swim through) this block or not.
    public let can_passthrough:Bool
    public let passthrough_velocity_dampen_x:Float
    public let passthrough_velocity_dampen_y:Float
    public let passthrough_velocity_dampen_z:Float
    
    /// Whether an Entity gets damaged from falling on this block or not.
    public let breaks_fall:Bool
    
    /// If this block breaks instantly when attacked.
    public let breaks_instantly:Bool
    public let resistance:Int
    
    public let dropped_items:[ItemStack]?
}
