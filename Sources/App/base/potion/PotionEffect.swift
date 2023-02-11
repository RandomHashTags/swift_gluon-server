//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class PotionEffect : Jsonable {
    public static func == (lhs: PotionEffect, rhs: PotionEffect) -> Bool {
        return lhs.type == rhs.type && lhs.has_icon == rhs.has_icon && lhs.has_particles == rhs.has_particles && lhs.is_ambient == rhs.is_ambient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
    }
    
    public let type:PotionEffectType
    public var has_icon:Bool
    public var has_particles:Bool
    public var is_ambient:Bool
    
    public var amplifier:UInt16
    public var duration:UInt16
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(has_icon)
        hasher.combine(has_particles)
        hasher.combine(is_ambient)
        hasher.combine(amplifier)
        hasher.combine(duration)
    }
}
