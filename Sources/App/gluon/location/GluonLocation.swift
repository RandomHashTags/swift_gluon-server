//
//  GluonLocation.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

struct GluonLocation : Location {
    var world:any World
    var x:HugeFloat
    var y:HugeFloat
    var z:HugeFloat
    
    var yaw:Double
    var pitch:Double
}
