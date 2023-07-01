//
//  GluonGameMode.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

struct GluonGameMode : GameMode {
    let id:String
    let name:String
    
    let allows_flight:Bool
    
    let can_break_blocks:Bool
    let can_breathe_underwater:Bool
    let can_pickup_items:Bool
    let can_place_blocks:Bool
    
    let is_affected_by_gravity:Bool
    let is_damageable:Bool
    let is_invisible:Bool
    
    let loses_hunger:Bool
}
