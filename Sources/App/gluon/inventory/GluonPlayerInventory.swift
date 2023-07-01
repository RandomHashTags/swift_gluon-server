//
//  GluonPlayerInventory.swift
//  
//
//  Created by Evan Anderson on 4/26/23.
//

import Foundation

struct GluonPlayerInventory : PlayerInventory {
    var type:any InventoryType
    
    var helmet:(any ItemStack)?
    var chestplate:(any ItemStack)?
    var leggings:(any ItemStack)?
    var boots:(any ItemStack)?
    
    var item_in_main_hand:(any ItemStack)?
    var item_in_off_hand:(any ItemStack)?
    
    var held_item_slot:Int
    
    var items:[(any ItemStack)?]
    var viewers:[any Player]
    
    init(type: any InventoryType, held_item_slot: Int, items: [(any ItemStack)?], viewers: [any Player]) {
        self.type = type
        self.held_item_slot = held_item_slot
        self.items = items
        self.viewers = viewers
    }
}
