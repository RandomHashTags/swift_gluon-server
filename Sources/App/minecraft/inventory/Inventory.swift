//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Inventory {
    var type : any InventoryType { get }
    var items : [(ItemStack)?] { get set }
    var viewers : [any Player] { get set }
        
    func contains(_ material: Material) -> Bool
    func contains(_ item: ItemStack) -> Bool
    
    func first(_ material: Material) -> (ItemStack)?
    func first(_ item: ItemStack) -> (ItemStack)?
    
    func get_item(slot: Int) -> (ItemStack)?
    mutating func set_item(slot: Int, item: (ItemStack)?)
    mutating func set_items(items: [(ItemStack)?])
    mutating func add_item(item: (ItemStack))
}
public extension Inventory {
    static func == (lhs: any Inventory, rhs: any Inventory) -> Bool {
        return lhs.type.id.elementsEqual(rhs.type.id) /*&& lhs.items.elementsEqual(rhs.items)*/ // TODO: fix
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.id)
        for item in items {
            if let item:ItemStack = item {
                hasher.combine(item)
            }
        }
    }
    
    func contains(_ material: Material) -> Bool {
        return first(material) != nil
    }
    func contains(_ item: ItemStack) -> Bool {
        return first(item) != nil
    }
    
    func first(_ material: Material) -> (ItemStack)? {
        let identifier:String = material.id
        return items.first(where: { $0?.material?.id.elementsEqual(identifier) ?? false }) ?? nil
    }
    func first(_ item: ItemStack) -> (ItemStack)? {
        return items.first(where: { item.is_similar($0) }) ?? nil
    }
    
    
    func get_item(slot: Int) -> (ItemStack)? {
        return items.get(slot) ?? nil
    }
    
    mutating func set_item(slot: Int, item: (ItemStack)?) {
        items[slot] = item
    }
    mutating func set_items(items: [(ItemStack)?]) {
        self.items = items
    }
    
    mutating func add_item(item: (ItemStack)) {
        // TODO: finish
    }
}
