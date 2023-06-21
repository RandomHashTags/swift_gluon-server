//
//  GluonBlock.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

struct GluonBlock : Block {
    typealias TargetMaterial = GluonMaterial
    typealias TargetItemStack = GluonItemStack
    typealias TargetLocation = GluonLocation
    typealias TargetLootTable = GluonLootTable
    
    var material_identifier:String
    var material : TargetMaterial? {
        return GluonServer.shared_instance.get_material(identifier: material_identifier)
    }
    var light_level:UInt8
    var location:TargetLocation
    
    var growable_age:UInt8?
    
    var loot_table:TargetLootTable?
    
    func tick(_ server: any Server) {
    }
    
    func break_naturally() {
        guard let loot:[TargetItemStack] = loot_table?.loot_normal else { return }
        let world:GluonWorld = location.world
        let pickup_delay:UInt8 = GluonServer.shared_instance.ticks_per_second / 2
        let half:HugeFloat = HugeFloat("0.5")
        let item_location:TargetLocation = location.advanced_by(x: half, y: half, z: half)
        for item_stack in loot {
            //let item:GluonItem = GluonItem(item_stack: item_stack, pickup_delay: pickup_delay, location: item_location)
            //world.spawn_entity(item)
        }
    }
    func get_breaking_speed(_ item_stack: TargetItemStack) -> Float {
       guard let block_configuration:GluonMaterialBlockConfiguration = material?.configuration.block else {
           return 0
       }
       
       let item_material:TargetMaterial = item_stack.material
       let hardness:Float = block_configuration.hardness
       
       let is_preferred_tool:Bool = block_configuration.preferred_break_materials?.contains(item_material) ?? false
       let tool_multiplier:Float, additional_multiplier:Float
       if is_preferred_tool {
           tool_multiplier = 1.5
           additional_multiplier = 1.0
       } else {
           tool_multiplier = 5.0
           additional_multiplier = 1.0
       }
       var penalties_multiplier:Float = 1.0
       
       return hardness * tool_multiplier * penalties_multiplier * additional_multiplier
    }
    func get_breaking_speed(_ player: any Player) -> Float {
        var speed_multiplier:Float = 1.0
        
        let potion_effects:[String:any PotionEffect] = player.potion_effects
        for (identifier, potion_effect) in potion_effects {
        }
        
        if !player.is_on_ground {
            speed_multiplier /= 5
        }
        
        var ticks:Float = 1.0
        return ticks / Float(GluonServer.shared_instance.ticks_per_second)
    }
}
