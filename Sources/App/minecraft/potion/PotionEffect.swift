//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol PotionEffect : AnyObject, Tickable, Identifiable where ID == String {
    var type : (any PotionEffectType)? { get }
    var has_icon : Bool { get set }
    var has_particles : Bool { get set }
    var is_ambient : Bool { get set }
    
    var amplifier : UInt16 { get set }
    /// Remaining duration of ticks for this potion effect.
    var duration : UInt16 { get set }
}

public extension PotionEffect {
    static func == (lhs: any PotionEffect, rhs: any PotionEffect) -> Bool {
        return lhs.id.elementsEqual(rhs.id) && lhs.has_icon == rhs.has_icon && lhs.has_particles == rhs.has_particles && lhs.is_ambient == rhs.is_ambient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(amplifier)
        hasher.combine(duration)
    }
    
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        duration /= divisor
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        duration *= multiplier
    }
}
