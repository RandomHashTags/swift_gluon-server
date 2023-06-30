//
//  GluonPotionEffect.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonPotionEffect : PotionEffect {
    let type_id:String
    var type : (any PotionEffectType)? {
        return GluonServer.shared_instance.get_potion_effect_type(identifier: type_id)
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
