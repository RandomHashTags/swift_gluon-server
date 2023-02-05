//
//  Location.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Location : Hashable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.world == rhs.world && lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.yaw == rhs.yaw && lhs.pitch == rhs.pitch
    }
    
    public var world:UnsafePointer<World>
    public var x:Float
    public var y:Float
    public var z:Float
    public var yaw:Float
    public var pitch:Float
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(world)
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(yaw)
        hasher.combine(pitch)
    }
    
    public init(world: UnsafePointer<World>, x: Float, y: Float, z: Float, yaw: Float, pitch: Float) {
        self.world = world
        self.x = x
        self.y = y
        self.z = z
        self.yaw = yaw
        self.pitch = pitch
    }
    
    public func is_similar(_ location: Location) -> Bool {
        return world == location.world && x == location.x && y == location.y && z == location.z
    }
}
