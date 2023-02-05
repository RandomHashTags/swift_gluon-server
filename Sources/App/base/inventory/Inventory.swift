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
    
    func contains(_ item: ItemStack) -> Bool {
        return items.first(where: { $0?.is_similar(item) ?? false }) != nil
    }
    func get_item(slot: Int) -> ItemStack? {
        return items.get(slot) ?? nil
    }
    func set_item(slot: Int, item: ItemStack?) {
        items[slot] = item
    }
    func add_item(item: ItemStack) {
        // TODO: finish
    }
}
