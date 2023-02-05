//
//  PotionEffect.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct PotionEffect : Jsonable {
    public let type:PotionEffectType
    public var has_icon:Bool
    public var has_particles:Bool
    public var is_ambient:Bool
    
    public var amplifier:UInt16
    public var duration:UInt16
}
