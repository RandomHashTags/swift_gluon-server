//
//  GluonPotionEffect.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonPotionEffect : PotionEffect {
    let type_identifier:String
    var type : PotionEffectType? {
        return GluonServer.shared_instance.get_potion_effect_type(identifier: type_identifier)
    }
    
    var has_icon:Bool
    var has_particles:Bool
    var is_ambient:Bool
    
    var amplifier:UInt16
    /// Remaining duration of ticks for this potion effect.
    var duration:UInt16
    
    mutating func tick(_ server: any Server) {
        duration -= 1
    }
}
