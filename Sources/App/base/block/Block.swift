//
//  Block.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Block : Jsonable, Tickable, Saveable {
    var material_identifier : String { get set }
    var light_level : UInt8 { get set }
    var location : Location { get set }
    
    var growable_age : UInt8? { get set }
    
    var loot_table : LootTable? { get set }
    
    func break_naturally()
    func is_preferred_tool(_ material: Material) -> Bool
    /// Measured in seconds.
    func get_breaking_speed(_ item_stack: ItemStack) -> Float
    func get_breaking_speed(_ player: any Player) -> Float
}

public extension Block {
    var material : Material? {
        return GluonServer.get_material(identifier: material_identifier)
    }
    
    var is_fully_grown : Bool {
        return growable_age ?? 0 >= material?.configuration.block?.growable?.maximum_age ?? 0
    }
    
    func break_naturally() {
        if let loot:[ItemStack] = loot_table?.loot_normal, let world:any World = location.world {
            let pickup_delay:UInt8 = GluonServer.shared_instance.ticks_per_second/2
            let item_location:Location = location.advanced_by(x: 0.5, y: 0.5, z: 0.5)
            for item_stack in loot {
                let item:Item = Item(item_stack: item_stack, pickup_delay: pickup_delay, location: item_location)
                world.spawn_entity(item)
            }
        }
    }
    
    func is_preferred_tool(_ material: Material) -> Bool {
        return self.material?.configuration.block?.preferred_break_materials?.contains(material) ?? false
    }
    func get_breaking_speed(_ item_stack: ItemStack) -> Float {
       guard let block_configuration:MaterialBlockConfiguration = material?.configuration.block else {
           return 0
       }
       
       let item_material:Material = item_stack.material
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
        var penalties_multiplier:Float = 1.0
        return 0
    }
}
