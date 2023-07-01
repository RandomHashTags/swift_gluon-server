//
//  GameMode.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol GameMode : MultilingualName, Identifiable where ID == String {    
    var allows_flight : Bool { get }
    
    /// The ``InventoryClickType`` ids not allowed for this game mode.
    var disallowed_inventory_click_types : Set<String> { get }
    
    var can_break_blocks : Bool { get }
    var can_breathe_underwater : Bool { get }
    var can_pickup_items : Bool { get }
    var can_place_blocks : Bool { get }
    
    var is_affected_by_gravity : Bool { get }
    var is_damageable : Bool { get }
    var is_invisible : Bool { get }
    
    var loses_hunger : Bool { get }
}
