//
//  Vector.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public class Vector : Jsonable {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    public var x:Double
    public var y:Double
    public var z:Double
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
    
    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}
