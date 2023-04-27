//
//  GluonPlayerInventory.swift
//  
//
//  Created by Evan Anderson on 4/26/23.
//

import Foundation

struct GluonPlayerInventory : PlayerInventory {
    typealias TargetInventoryType = GluonInventoryType
    typealias TargetItemStack = GluonItemStack
    typealias TargetMaterial = GluonMaterial
    typealias TargetPlayer = GluonPlayer
    
    var helmet:TargetItemStack?
    var chestplate:TargetItemStack?
    var leggings:TargetItemStack?
    var boots:TargetItemStack?
    
    var item_in_main_hand:TargetItemStack?
    var item_in_off_hand:TargetItemStack?
    
    var type:TargetInventoryType
    var items:[TargetItemStack?]
    var viewers:Set<TargetPlayer>
    
    init(type: TargetInventoryType, items: [TargetItemStack?], viewers: Set<TargetPlayer>) {
        self.type = type
        self.items = items
        self.viewers = viewers
    }
}
