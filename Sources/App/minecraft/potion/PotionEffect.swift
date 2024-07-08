//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol PotionEffect : AnyObject, Tickable, Identifiable where ID == String {
    var typeID : String { get }
    var hasIcon : Bool { get set }
    var hasParticles : Bool { get set }
    var isAmbient : Bool { get set }
    
    var amplifier : UInt16 { get set }
    /// Remaining duration of ticks for this potion effect.
    var duration : UInt16 { get set }
}

public extension PotionEffect {
    static func == (lhs: any PotionEffect, rhs: any PotionEffect) -> Bool {
        return lhs.id.elementsEqual(rhs.id) && lhs.hasIcon == rhs.hasIcon && lhs.hasParticles == rhs.hasParticles && lhs.isAmbient == rhs.isAmbient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
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
