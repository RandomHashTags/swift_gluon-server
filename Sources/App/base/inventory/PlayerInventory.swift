//
//  PlayerInventory.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public protocol PlayerInventory : Inventory {
    var helmet : TargetItemStack? { get set }
    var chestplate : TargetItemStack? { get set }
    var leggings : TargetItemStack? { get set }
    var boots : TargetItemStack? { get set }
    
    var item_in_main_hand : TargetItemStack? { get set }
    var item_in_off_hand : TargetItemStack? { get set }
}
