//
//  DefaultInventoryClickType.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public enum DefaultInventoryClickType : String, CaseIterable, InventoryClickType {
    case pickup = "minecraft.pickup"
    case quick_move = "minecraft.quick_move"
    case swap = "minecraft.swap"
    case clone = "minecraft.clone"
    case `throw` = "minecraft.throw"
    case quick_craft = "minecraft.quick_craft"
    case pickup_all = "minecraft.pickup_all"
    
    public var id : String {
        return rawValue
    }
}
