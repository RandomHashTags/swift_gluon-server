//
//  GluonMaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonMaterialBlockConfiguration : MaterialBlockConfiguration {
    typealias TargetMaterialBlockLiquidConfiguration = GluonMaterialBlockLiquidConfiguration
    typealias TargetMaterial = GluonMaterial
    typealias TargetLootTable = GluonLootTable
    
    let type:BlockType
    
    let block_move_reaction:BlockMoveReaction
    
    let growable:MaterialBlockGrowableConfiguration?
    
    let liquid:TargetMaterialBlockLiquidConfiguration?
    
    let can_passthrough:Bool
    let passthrough_velocity_dampen_x:Float
    let passthrough_velocity_dampen_y:Float
    let passthrough_velocity_dampen_z:Float
    
    let breaks_fall:Bool
    
    let resistance:Int
    let hardness:Float
    let preferred_break_material_identifiers:Set<String>?
    var preferred_break_materials : Set<TargetMaterial>? {
        guard let identifiers:Set<String> = preferred_break_material_identifiers else { return nil }
        return GluonServer.shared_instance.get_materials(identifiers: identifiers)
    }
    
    let loot:TargetLootTable?
}
