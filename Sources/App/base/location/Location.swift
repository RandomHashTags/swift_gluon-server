//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public struct Location : Jsonable {
    public var world_name:String
    public var world : (any World)? {
        return GluonServer.get_world(name: world_name)
    }
    public var x:HugeFloat
    public var y:HugeFloat
    public var z:HugeFloat
    public var yaw:Double
    public var pitch:Double
    
    public var chunk_coordinates : (x: Int64, z: Int64) {
        return (x: Int64(floor(x / 16)), z: Int64(floor(z / 16)))
    }
    
    /// Whether or not the two locations are the same, regardless of `yaw` or `pitch`.
    public func is_similar(_ location: Location) -> Bool {
        return world_name.elementsEqual(location.world_name) && x == location.x && y == location.y && z == location.z
    }
    
    public func is_nearby(center: Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> Bool {
        let (dis_x, dis_y, dis_z):(HugeFloat, HugeFloat, HugeFloat) = distance(to: center)
        return abs(dis_x) <= x_radius && abs(dis_y) <= y_radius && abs(dis_z) <= z_radius
    }
    /// Gets the distance between two locations, regardless of world.
    public func distance(to location: Location) -> (x: HugeFloat, y: HugeFloat, z: HugeFloat) {
        let loc_x:HugeFloat = location.x, loc_y:HugeFloat = location.y, loc_z:HugeFloat = location.z
        return ((loc_x - x), (loc_y - y), (loc_z - z))
    }
    
    /// Returns self after adding the specified distances to self.
    mutating func adding(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double) -> Location {
        self.x += x
        self.y += y
        self.z += z
        self.yaw += yaw
        self.pitch += pitch
        return self
    }
    /// Returns a new `Location` by adding the specified distances to this location.
    func advanced_by(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double = 0, pitch: Double = 0) -> Location {
        return Location(world_name: world_name, x: self.x + x, y: self.y + y, z: self.z + z, yaw: self.yaw + yaw, pitch: self.pitch + pitch)
    }
}
