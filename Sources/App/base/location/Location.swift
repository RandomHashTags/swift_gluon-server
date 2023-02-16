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
    public var x:Double
    public var y:Double
    public var z:Double
    public var yaw:Double
    public var pitch:Double
    
    public func is_similar(_ location: Location) -> Bool {
        return world_name.elementsEqual(location.world_name) && x == location.x && y == location.y && z == location.z
    }
    
    public func is_nearby(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> Bool {
        let (dis_x, dis_y, dis_z):(Double, Double, Double) = distance(to: center)
        return abs(dis_x) <= x_radius && abs(dis_y) <= y_radius && abs(dis_z) <= z_radius
    }
    /// Gets the distance between two locations, regardless of world.
    public func distance(to location: Location) -> (x: Double, y: Double, z: Double) {
        let loc_x:Double = location.x, loc_y:Double = location.y, loc_z:Double = location.z
        return ((loc_x - x), (loc_y - y), (loc_z - z))
    }
    
    /// Adds the specified distances to itself, and returns self.
    mutating func adding(x: Double, y: Double, z: Double, yaw: Double, pitch: Double) -> Location {
        self.x += x
        self.y += y
        self.z += z
        self.yaw += yaw
        self.pitch += pitch
        return self
    }
    /// Returns a new `Location` adding the specified distances to this location.
    func advanced_by(x: Double, y: Double, z: Double, yaw: Double = 0, pitch: Double = 0) -> Location {
        return Location(world_name: world_name, x: self.x + x, y: self.y + y, z: self.z + z, yaw: self.yaw + yaw, pitch: self.pitch + pitch)
    }
}
