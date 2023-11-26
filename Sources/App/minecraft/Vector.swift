//
//  Vector.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public class Vector : Hashable {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    public var x:Float
    public var y:Float
    public var z:Float
    
    public init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}
