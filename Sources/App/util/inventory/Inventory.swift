//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Inventory {
    public let type:UnsafePointer<InventoryType>
    private var items:Array<ItemStack?>
    public var viewers:Set<Player>
    
    public init(type: UnsafePointer<InventoryType>, items: [ItemStack?], viewers: Set<Player>) {
        self.type = type
        self.items = items
        self.viewers = viewers
    }
    
    func get_item(slot: Int) -> ItemStack? {
        return items.get(slot) ?? nil
    }
    func set_item(slot: Int, item: ItemStack?) {
        items[slot] = item
    }
    func add_item(item: ItemStack) {
        var first_empty_slot:Int = -1
        for slot in 0..<type.pointee.size {
            let target_item:ItemStack? = items[slot]
            if first_empty_slot == -1 && target_item == nil {
                first_empty_slot = slot
            }
            if target_item != nil && target_item!.is_similar(item) {
                // TODO: finish
            }
        }
    }
}
