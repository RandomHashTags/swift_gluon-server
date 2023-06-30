//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol PotionEffect : Tickable {
    var type_id : String { get }
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
        return lhs.type_id.elementsEqual(rhs.type_id) && lhs.has_icon == rhs.has_icon && lhs.has_particles == rhs.has_particles && lhs.is_ambient == rhs.is_ambient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type_id)
        hasher.combine(amplifier)
        hasher.combine(duration)
    }
}
