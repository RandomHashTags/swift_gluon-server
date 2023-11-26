//
//  BlockBehavior.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

public protocol BlockBehavior {
    var has_collision : Bool { get }
    var explosion_resistance : Float { get }
    var is_randomly_ticking : Bool { get }
    var sound_type : any SoundType { get }
    var friction : Float { get set }
    var speed_factor : Float { get set }
    var jump_factor : Float { get set }
    var dynamic_shape : Bool { get }
}
