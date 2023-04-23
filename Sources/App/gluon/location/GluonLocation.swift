//
//  GluonLocation.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

public struct GluonLocation : Location {
    public typealias TargetWorld = GluonWorld
    
    public var world_name:String
    public var world : TargetWorld? {
        return GluonServer.shared_instance.get_world(name: world_name)
    }
    public var x:HugeFloat
    public var y:HugeFloat
    public var z:HugeFloat
    
    public var yaw:Double
    public var pitch:Double
    
    public init(world_name: String, x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double) {
        self.world_name = world_name
        self.x = x
        self.y = y
        self.z = z
        self.yaw = yaw
        self.pitch = pitch
    }
}
