//
//  NBTPotionEffect.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

public protocol NBTPotionEffect : NBTTag {
    var ambient : Bool { get }
    var amplifier : Bool { get }
    var duration : Int { get }
    var hiddenEffect : String { get } // TODO: fix
    var id : Int { get }
    var showIcon : Bool { get }
    var showParticles : Bool { get }
}