//
//  GameMode.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct GameMode : Jsonable {
    public let identifier:String
    
    public let allows_flight:Bool
    
    public let can_break_blocks:Bool
    public let can_breathe_underwater:Bool
    public let can_pickup_items:Bool
    public let can_place_blocks:Bool
    
    public let is_affected_by_gravity:Bool
    public let is_damageable:Bool
    public let is_invisible:Bool
    
    public let loses_hunger:Bool
}
