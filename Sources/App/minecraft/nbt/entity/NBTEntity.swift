//
//  NBTEntity.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTEntity : NBTTag {
    var air : Int { get }
    var customName : String { get }
    var customNameVisible : Bool { get }
    var fallDistance : Float { get }
    var fire : Int { get }
    var glowing : Bool { get }
    var hasVisualFire : Bool { get }
    var id : String { get }
    var invulnerable : Bool { get }
    var motion : [Double] { get }
    var noGravity : Bool { get }
    var onGround : Bool { get }
    var passengers : [UUID] { get }
    var portalCooldown : Int { get }
    var pos : [Double] { get }
    var rotation : [Float] { get }
    var silent : Bool { get }
    var tags : [String] { get } // TODO: fix
    var ticksFrozen : Int? { get }
    var uuid : UUID { get }
}