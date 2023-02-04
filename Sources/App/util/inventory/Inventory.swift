//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Inventory {
    public let type:UnsafePointer<InventoryType>
    public var items:[ItemStack]?
    public var viewers:Set<Player>
    
    public init(type: UnsafePointer<InventoryType>, items: [ItemStack]?, viewers: Set<Player>) {
        self.type = type
        self.items = items
        self.viewers = viewers
    }
    
    func set_item(slot: UInt8) {
    }
}
