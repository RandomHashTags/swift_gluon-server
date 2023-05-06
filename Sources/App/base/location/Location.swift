//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public protocol Location : Jsonable {
    associatedtype TargetWorld : World
    
    var world : TargetWorld { get set }
    var x : HugeFloat { get set }
    var y : HugeFloat { get set }
    var z : HugeFloat { get set }
    var yaw : Double { get set }
    var pitch : Double { get set }
    
    init(world: TargetWorld, x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double)
    
    var chunk_coordinates : (x: HugeInt, z: HugeInt) { get }
    
    /// Whether or not the two locations are the same, regardless of `yaw` or `pitch`.
    func is_similar(_ location: Self) -> Bool
    
    func is_nearby(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> Bool
    /// Gets the distance between two locations, regardless of world.
    func distance(to location: any Location) -> (x: HugeFloat, y: HugeFloat, z: HugeFloat)
    
    /// Returns self after adding the specified distances to self.
    mutating func adding(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double) -> Self
    
    /// Returns a new `Location` by adding the specified distances to this location.
    func advanced_by(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double) -> Self
}
public extension Location {
    var chunk_coordinates : (x: HugeInt, z: HugeInt) {
        return (x: (x / 16).integer, z: (z / 16).integer)
    }
    
    func is_similar(_ location: Self) -> Bool {
        return world == location.world && x == location.x && y == location.y && z == location.z
    }
    
    func is_nearby(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> Bool {
        let (dis_x, dis_y, dis_z):(HugeFloat, HugeFloat, HugeFloat) = distance(to: center)
        return abs(dis_x) <= x_radius && abs(dis_y) <= y_radius && abs(dis_z) <= z_radius
    }
    func distance(to location: any Location) -> (x: HugeFloat, y: HugeFloat, z: HugeFloat) {
        let loc_x:HugeFloat = location.x, loc_y:HugeFloat = location.y, loc_z:HugeFloat = location.z
        return ((loc_x - x), (loc_y - y), (loc_z - z))
    }
    
    mutating func adding(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double, pitch: Double) -> Self {
        self.x += x
        self.y += y
        self.z += z
        self.yaw += yaw
        self.pitch += pitch
        return self
    }
    
    func advanced_by(x: HugeFloat, y: HugeFloat, z: HugeFloat, yaw: Double = 0, pitch: Double = 0) -> Self {
        return Self(world: world, x: self.x + x, y: self.y + y, z: self.z + z, yaw: self.yaw + yaw, pitch: self.pitch + pitch)
    }
}
