//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Inventory {
    var type:InventoryType { get }
    var items:Array<ItemStack?> { get set }
    var viewers:Set<UUID> { get set }
    
    func get_item(slot: Int) -> ItemStack?
    func set_item(slot: Int, item: ItemStack?)
    func add_item(item: ItemStack)
}
