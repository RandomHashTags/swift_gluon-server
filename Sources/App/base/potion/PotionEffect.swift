//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class PotionEffect : Jsonable {
    public static func == (lhs: PotionEffect, rhs: PotionEffect) -> Bool {
        return lhs.type_identifier.elementsEqual(rhs.type_identifier) && lhs.has_icon == rhs.has_icon && lhs.has_particles == rhs.has_particles && lhs.is_ambient == rhs.is_ambient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
    }
    
    public let type_identifier:String
    public var type : PotionEffectType? {
        return GluonServer.get_potion_effect_type(identifier: type_identifier)
    }
    public var has_icon:Bool
    public var has_particles:Bool
    public var is_ambient:Bool
    
    public var amplifier:UInt16
    /// Remaining duration of ticks for this potion effect.
    public var duration:UInt16
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type_identifier)
        hasher.combine(has_icon)
        hasher.combine(has_particles)
        hasher.combine(is_ambient)
        hasher.combine(amplifier)
        hasher.combine(duration)
    }
}
