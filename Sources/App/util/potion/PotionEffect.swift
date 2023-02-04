//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class PotionEffect : Hashable {
    public static func == (lhs: PotionEffect, rhs: PotionEffect) -> Bool {
        return lhs.type == rhs.type && lhs.has_icon == rhs.has_icon && lhs.has_particles == rhs.has_particles && lhs.is_ambient == rhs.is_ambient && lhs.amplifier == rhs.amplifier && lhs.duration == rhs.duration
    }
    
    public var type:UnsafePointer<PotionEffectType>
    public var has_icon:Bool
    public var has_particles:Bool
    public var is_ambient:Bool
    
    public var amplifier:UInt16
    public var duration:UInt16
    
    public init(type: UnsafePointer<PotionEffectType>, has_icon: Bool, has_particles: Bool, is_ambient: Bool, amplifier: UInt16, duration: UInt16) {
        self.type = type
        self.has_icon = has_icon
        self.has_particles = has_particles
        self.is_ambient = is_ambient
        self.amplifier = amplifier
        self.duration = duration
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
