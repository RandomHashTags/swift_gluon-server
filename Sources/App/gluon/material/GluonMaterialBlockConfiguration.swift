//
//  GluonMaterialBlockConfiguration.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonMaterialBlockConfiguration : MaterialBlockConfiguration {
    public typealias TargetMaterialBlockLiquidConfiguration = GluonMaterialBlockLiquidConfiguration
    public typealias TargetMaterial = GluonMaterial
    
    public let type:BlockType
    
    public let block_move_reaction:BlockMoveReaction
    
    public let growable:MaterialBlockGrowableConfiguration?
    
    public let liquid:TargetMaterialBlockLiquidConfiguration?
    
    public let can_passthrough:Bool
    public let passthrough_velocity_dampen_x:Float
    public let passthrough_velocity_dampen_y:Float
    public let passthrough_velocity_dampen_z:Float
    
    public let breaks_fall:Bool
    
    public let resistance:Int
    public let hardness:Float
    public let preferred_break_material_identifiers:Set<String>?
    public var preferred_break_materials : Set<TargetMaterial>? {
        guard let identifiers:Set<String> = preferred_break_material_identifiers else { return nil }
        return GluonServer.shared_instance.get_materials(identifiers: identifiers)
    }
    
    public let loot:LootTable?
}
