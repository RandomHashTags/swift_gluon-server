//
//  GluonLocation.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonLocation : Location {
    var world:any World
    var x:Double
    var y:Double
    var z:Double
    
    var yaw:Double
    var pitch:Double
}
