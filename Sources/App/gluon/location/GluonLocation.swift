//
//  GluonLocation.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

struct GluonLocation : Location {
    typealias TargetWorld = GluonWorld
    
    var world_name:String
    var world : TargetWorld? {
        return GluonServer.shared_instance.get_world(name: world_name)
    }
    var x:HugeFloat
    var y:HugeFloat
    var z:HugeFloat
    
    var yaw:Double
    var pitch:Double
}
