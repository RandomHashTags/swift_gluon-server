//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Inventory : Jsonable {
    public static func == (lhs: Inventory, rhs: Inventory) -> Bool {
        return lhs.type == rhs.type && lhs.items.elementsEqual(rhs.items)
    }
    
    public let type:InventoryType
    private var items:Array<ItemStack?>
    public var viewers:Set<Player>
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(items)
    }
    
    public init(type: InventoryType, items: Array<ItemStack?>, viewers: Set<Player>) {
        self.type = type
        self.items = items
        self.viewers = viewers
    }
    
    func contains(_ material: Material) -> Bool {
        return first(material) != nil
    }
    func contains(_ item: ItemStack) -> Bool {
        return first(item) != nil
    }
    
    func first(_ material: Material) -> ItemStack? {
        return items.first(where: { $0?.material == material }) ?? nil
    }
    func first(_ item: ItemStack) -> ItemStack? {
        return items.first(where: {  item.is_similar($0) }) ?? nil
    }
    
    
    func get_item(slot: Int) -> ItemStack? {
        return items.get(slot) ?? nil
    }
    
    func set_item(slot: Int, item: ItemStack?) {
        items[slot] = item
    }
    func set_items(items: Array<ItemStack?>) {
        self.items = items
    }
    
    func add_item(item: ItemStack) {
        // TODO: finish
    }
}
