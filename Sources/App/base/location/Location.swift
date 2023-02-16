//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public final class Location : Jsonable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.world_name.elementsEqual(rhs.world_name) && lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.yaw == rhs.yaw && lhs.pitch == rhs.pitch
    }
    
    public var world_name:String
    public var world : World? {
        return GluonServer.get_world(name: world_name)
    }
    public var x:Double
    public var y:Double
    public var z:Double
    public var yaw:Double
    public var pitch:Double
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(world_name)
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
    
    public init(world_name: String, x: Double, y: Double, z: Double, yaw: Double, pitch: Double) {
        self.world_name = world_name
        self.x = x
        self.y = y
        self.z = z
        self.yaw = yaw
        self.pitch = pitch
    }
    
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
}
