//
//  GluonEntityType.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation
import SwiftStringCatalogs

final class GluonEntityType : EntityType {
    let id:String
    let name:LocalizedStringResource
    
    let is_affected_by_gravity:Bool
    let is_damageable:Bool
    
    let receives_fall_damage:Bool
    
    var no_damage_ticks_maximum:UInt16
    var fire_ticks_maximum:UInt16
    var freeze_ticks_maximum:UInt16
    
    init(
        id: String,
        name: LocalizedStringResource,
        is_affected_by_gravity: Bool,
        is_damageable: Bool,
        receives_fall_damage: Bool,
        no_damage_ticks_maximum: UInt16,
        fire_ticks_maximum: UInt16,
        freeze_ticks_maximum: UInt16
    ) {
        self.id = id
        self.name = name
        self.is_affected_by_gravity = is_affected_by_gravity
        self.is_damageable = is_damageable
        self.receives_fall_damage = receives_fall_damage
        self.no_damage_ticks_maximum = no_damage_ticks_maximum
        self.fire_ticks_maximum = fire_ticks_maximum
        self.freeze_ticks_maximum = freeze_ticks_maximum
    }
}
