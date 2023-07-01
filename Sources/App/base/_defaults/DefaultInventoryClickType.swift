//
//  DefaultInventoryClickType.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public enum DefaultInventoryClickType : String, CaseIterable, InventoryClickType {
    case clone
    case pickup
    case pickup_all
    case quick_move
    case quick_craft
    case set
    case set_all
    case swap
    case `throw`
    
    public var id : String {
        return "minecraft." + rawValue
    }
}
