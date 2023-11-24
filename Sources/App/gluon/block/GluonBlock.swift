//
//  GluonBlock.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonBlock : Block {
    let material_id:String
    var material : (any Material)? {
        return GluonServer.shared_instance.get_material(identifier: material_id)
    }
    
    let requires_correct_tool_for_drops:Bool
    let has_collision:Bool
    
    let instrument_id:String?
    var instrument : (any Instrument)? {
        guard let instrument_id:String = instrument_id else { return nil }
        return GluonServer.shared_instance.get_instrument(identifier: instrument_id)
    }
    
    let map_color:Color?
    
    let step_sound:(any Sound)?
    
    var light_level:UInt8
    var location:any Location
    
    var growable_age:UInt8?
    
    var loot_table:(any LootTable)?
    
    func tick(_ server: any Server) {
    }
    
    func break_naturally() {
        guard let loot:[any ItemStack] = loot_table?.loot_normal else { return }
        let world:any World = location.world
        let pickup_delay:UInt8 = GluonServer.shared_instance.ticks_per_second / 2
        let half:Double = 0.5
        let item_location:any Location = location.advanced_by(x: half, y: half, z: half)
        for item_stack in loot {
            /*let item:GluonItem = GluonItem(item_stack: item_stack, pickup_delay: pickup_delay, location: item_location)
            world.spawn_entity(item)*/
        }
    }
    func get_breaking_speed(_ item_stack: any ItemStack) -> Float {
       guard let block_configuration:any MaterialBlockConfiguration = material?.configuration.block else {
           return 0
       }
       let hardness:Float = block_configuration.hardness
       let is_preferred_tool:Bool = block_configuration.preferred_break_material_identifiers?.contains(item_stack.material_id) ?? false
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
