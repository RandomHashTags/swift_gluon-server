//
//  Entity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Entity : Jsonable {
    var uuid:UUID { get }
    var type:EntityType { get }
    var display_name:String? { get set }
    
    var boundaries:[Boundary] { get set }
    var location:Location { get set }
    var velocity:Vector { get set }
    var fall_distance:Float { get set }
    
    var is_on_fire:Bool { get set }
    var is_on_ground:Bool { get set }
    
    var height:Float { get set }
    
    var fire_ticks:UInt16 { get set }
    var fire_ticks_maximum:UInt16 { get set }
    
    var freeze_ticks:UInt16 { get set }
    var freeze_ticks_maximum:UInt16 { get set }
    
    var passengers:[String] { get set }
    var vehicle:UUID? { get set }
    
    func tick()
}
