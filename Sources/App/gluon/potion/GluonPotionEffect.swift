//
//  GluonPotionEffect.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public struct GluonPotionEffect : PotionEffect {
    public let type_identifier:String
    public var type : PotionEffectType? {
        return GluonServer.shared_instance.get_potion_effect_type(identifier: type_identifier)
    }
    
    public var has_icon:Bool
    public var has_particles:Bool
    public var is_ambient:Bool
    
    public var amplifier:UInt16
    /// Remaining duration of ticks for this potion effect.
    public var duration:UInt16
    
    public mutating func tick(_ server: any Server) {
        duration -= 1
    }
}
