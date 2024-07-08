//
//  GluonMaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialBlockConfiguration : MaterialBlockConfiguration {
    let block_move_reaction:BlockMoveReaction
    
    let growable:MaterialBlockGrowableConfiguration?
    
    let liquid:(any MaterialBlockLiquidConfiguration)?
    
    let can_passthrough:Bool
    let passthrough_velocity_dampen_x:Float
    let passthrough_velocity_dampen_y:Float
    let passthrough_velocity_dampen_z:Float
    
    let breaks_fall:Bool
    
    let resistance:Int
    let hardness:Float
    let preferred_break_material_identifiers:Set<String>?
    var preferred_break_materials : [Material]? {
        guard let identifiers:Set<String> = preferred_break_material_identifiers else { return nil }
        return GluonServer.shared.get_materials(identifiers: identifiers)
    }
    
    let loot:(LootTable)?
}
