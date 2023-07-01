//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Inventory {
    var type : any InventoryType { get }
    var items : [(any ItemStack)?] { get set }
    var viewers : [any Player] { get set }
        
    func contains(_ material: any Material) -> Bool
    func contains(_ item: any ItemStack) -> Bool
    
    func first(_ material: any Material) -> (any ItemStack)?
    func first(_ item: any ItemStack) -> (any ItemStack)?
    
    func get_item(slot: Int) -> (any ItemStack)?
    mutating func set_item(slot: Int, item: (any ItemStack)?)
    mutating func set_items(items: [(any ItemStack)?])
    mutating func add_item(item: (any ItemStack))
}
public extension Inventory {
    static func == (lhs: any Inventory, rhs: any Inventory) -> Bool {
        return lhs.type.id.elementsEqual(rhs.type.id) /*&& lhs.items.elementsEqual(rhs.items)*/ // TODO: fix
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.id)
        for item in items {
            if let item:any ItemStack = item {
                hasher.combine(item)
            }
        }
    }
    
    func contains(_ material: any Material) -> Bool {
        return first(material) != nil
    }
    func contains(_ item: any ItemStack) -> Bool {
        return first(item) != nil
    }
    
    func first(_ material: any Material) -> (any ItemStack)? {
        let identifier:String = material.id
        return items.first(where: { $0?.material?.id.elementsEqual(identifier) ?? false }) ?? nil
    }
    func first(_ item: any ItemStack) -> (any ItemStack)? {
        return items.first(where: { item.is_similar($0) }) ?? nil
    }
    
    
    func get_item(slot: Int) -> (any ItemStack)? {
        return items.get(slot) ?? nil
    }
    
    mutating func set_item(slot: Int, item: (any ItemStack)?) {
        items[slot] = item
    }
    mutating func set_items(items: [(any ItemStack)?]) {
        self.items = items
    }
    
    mutating func add_item(item: (any ItemStack)) {
        // TODO: finish
    }
}
