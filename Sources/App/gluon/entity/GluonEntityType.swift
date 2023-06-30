//
//  GluonEntityType.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

struct GluonEntityType : EntityType {
    let id:String
    let name:LocalizedStringResource
    
    let is_affected_by_gravity:Bool
    let is_damageable:Bool
    
    let receives_fall_damage:Bool
    
    var no_damage_ticks_maximum:UInt16
    var fire_ticks_maximum:UInt16
    var freeze_ticks_maximum:UInt16
}
