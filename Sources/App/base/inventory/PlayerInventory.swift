//
//  PlayerInventory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public protocol PlayerInventory : Inventory {
    var helmet : (any ItemStack)? { get set }
    var chestplate : (any ItemStack)? { get set }
    var leggings : (any ItemStack)? { get set }
    var boots : (any ItemStack)? { get set }
    
    var item_in_main_hand : (any ItemStack)? { get set }
    var item_in_off_hand : (any ItemStack)? { get set }
}
