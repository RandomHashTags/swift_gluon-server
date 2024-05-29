//
//  NBTEntity.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTEntity : NBTTag {
    var air : Int { get }
    var custom_name : String { get }
    var custom_name_visible : Bool { get }
    var fall_distance : Float { get }
    var fire : Int { get }
    var glowing : Bool { get }
    var has_visual_fire : Bool { get }
    var id : String { get }
    var invulnerable : Bool { get }
    var motion : [Double] { get }
    var no_gravity : Bool { get }
    var on_ground : Bool { get }
    var passengers : [UUID] { get }
    var portal_cooldown : Int { get }
    var pos : [Double] { get }
    var rotation : [Float] { get }
    var silent : Bool { get }
    var tags : [String] { get } // TODO: fix
    var ticks_frozen : Int? { get }
    var uuid : UUID { get }
}