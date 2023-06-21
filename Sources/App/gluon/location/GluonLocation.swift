//
//  GluonLocation.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

struct GluonLocation : Location {
    typealias TargetWorld = GluonWorld
    
    var world:TargetWorld
    var x:HugeFloat
    var y:HugeFloat
    var z:HugeFloat
    
    var yaw:Double
    var pitch:Double
}
