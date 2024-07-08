//
//  PlayerInventory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public protocol PlayerInventory : Inventory {
    var helmet : (ItemStack)? { get set }
    var chestplate : (ItemStack)? { get set }
    var leggings : (ItemStack)? { get set }
    var boots : (ItemStack)? { get set }
    
    var item_in_main_hand : (ItemStack)? { get set }
    var item_in_off_hand : (ItemStack)? { get set }
    
    var held_item_slot : Int { get set }
}
