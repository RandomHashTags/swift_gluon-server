//
//  Inventory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Inventory : Jsonable {
    associatedtype TargetInventoryType : InventoryType
    associatedtype TargetItemStack : ItemStack
    associatedtype TargetMaterial : Material
    associatedtype TargetPlayer : Player
    
    var type : TargetInventoryType { get }
    var items : [TargetItemStack?] { get set }
    var viewers : Set<TargetPlayer> { get set }
    
    init(type: TargetInventoryType, items: [TargetItemStack?], viewers: Set<TargetPlayer>)
    
    func contains(_ material: TargetMaterial) -> Bool
    func contains(_ item: TargetItemStack) -> Bool
    
    func first(_ material: TargetMaterial) -> TargetItemStack?
    func first(_ item: TargetItemStack) -> TargetItemStack?
    
    func get_item(slot: Int) -> TargetItemStack?
    mutating func set_item(slot: Int, item: TargetItemStack?)
    mutating func set_items(items: [TargetItemStack?])
    mutating func add_item(item: TargetItemStack)
}
public extension Inventory {
    static func == (lhs: any Inventory, rhs: any Inventory) -> Bool {
        return lhs.type == rhs.type && lhs.items.elementsEqual(rhs.items)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(items)
    }
    
    func contains(_ material: TargetMaterial) -> Bool {
        return first(material) != nil
    }
    func contains(_ item: TargetItemStack) -> Bool {
        return first(item) != nil
    }
    
    func first(_ material: TargetMaterial) -> TargetItemStack? {
        return items.first(where: { $0?.material == material }) ?? nil
    }
    func first(_ item: TargetItemStack) -> TargetItemStack? {
        return items.first(where: {  item.is_similar($0) }) ?? nil
    }
    
    
    func get_item(slot: Int) -> TargetItemStack? {
        return items.get(slot) ?? nil
    }
    
    mutating func set_item(slot: Int, item: TargetItemStack?) {
        items[slot] = item
    }
    mutating func set_items(items: Array<TargetItemStack?>) {
        self.items = items
    }
    
    mutating func add_item(item: TargetItemStack) {
        // TODO: finish
    }
}
