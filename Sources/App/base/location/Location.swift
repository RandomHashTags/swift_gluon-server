//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Location : Jsonable {
    public var world_name:String
    public var world : World? {
        return GluonServer.get_world(name: world_name)
    }
    public var x:Float
    public var y:Float
    public var z:Float
    public var yaw:Float
    public var pitch:Float
    
    public func is_similar(_ location: Location) -> Bool {
        return world_name.elementsEqual(location.world_name) && x == location.x && y == location.y && z == location.z
    }
    
    public func is_nearby(_ location: Location, x_radius: Float, y_radius: Float, z_radius: Float) -> Bool {
        let loc_x:Float = location.x, loc_y:Float = location.y, loc_z:Float = location.z
        return world_name.elementsEqual(location.world_name) && (max(x, loc_x) - min(x, loc_x) <= x_radius) && (max(y, loc_y) - min(y, loc_y) <= y_radius) && (max(z, loc_z) - min(z, loc_z) <= z_radius)
    }
}
