//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Location : Hashable {
    var world : any World { get set }
    var x : Double { get set }
    var y : Double { get set }
    var z : Double { get set }
    var yaw : Double { get set }
    var pitch : Double { get set }
    
    init(world: any World, x: Double, y: Double, z: Double, yaw: Double, pitch: Double)
    
    var chunk_coordinates : (x: Int, z: Int) { get }
    
    /// Whether or not the two locations are the same, regardless of `yaw` or `pitch`.
    func is_similar(_ location: Self) -> Bool
    
    func is_nearby(center: any Location, x_radius: Double, y_radius: Double, z_radius: Double) -> Bool
    /// Gets the distance between two locations, regardless of world.
    func distance(to location: any Location) -> (x: Double, y: Double, z: Double)
    
    /// Returns self after adding the specified distances to self.
    mutating func adding(x: Double, y: Double, z: Double, yaw: Double, pitch: Double) -> Self
    
    /// Returns a new `Location` by adding the specified distances to this location.
    func advanced_by(x: Double, y: Double, z: Double, yaw: Double, pitch: Double) -> Self
}
public extension Location {
    static func == (left: any Location, right: any Location) -> Bool {
        return left.world.uuid == right.world.uuid && left.x == right.x && left.y == right.y && left.z == right.z && left.yaw == right.yaw && left.pitch == right.pitch
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(world.uuid)
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(yaw)
        hasher.combine(pitch)
    }
    
    var chunk_coordinates : (x: Int, z: Int) {
        return (x: (Int(x) / 16), z: (Int(z) / 16))
    }
    
    func is_similar(_ location: Self) -> Bool {
        return world.uuid == location.world.uuid && x == location.x && y == location.y && z == location.z
    }
    
    func is_nearby(center: any Location, x_radius: Double, y_radius: Double, z_radius: Double) -> Bool {
        let (dis_x, dis_y, dis_z):(Double, Double, Double) = distance(to: center)
        return abs(dis_x) <= x_radius && abs(dis_y) <= y_radius && abs(dis_z) <= z_radius
    }
    func distance(to location: any Location) -> (x: Double, y: Double, z: Double) {
        let loc_x:Double = location.x, loc_y:Double = location.y, loc_z:Double = location.z
        return ((loc_x - x), (loc_y - y), (loc_z - z))
    }
    
    mutating func adding(x: Double, y: Double, z: Double, yaw: Double, pitch: Double) -> Self {
        self.x += x
        self.y += y
        self.z += z
        self.yaw += yaw
        if self.yaw >= 360 {
            self.yaw -= 360
        }
        self.pitch += pitch
        if self.pitch >= 360 {
            self.pitch -= 360
        }
        return self
    }
    
    func advanced_by(x: Double, y: Double, z: Double, yaw: Double = 0, pitch: Double = 0) -> Self {
        return Self(world: world, x: self.x + x, y: self.y + y, z: self.z + z, yaw: self.yaw + yaw, pitch: self.pitch + pitch)
    }
}
