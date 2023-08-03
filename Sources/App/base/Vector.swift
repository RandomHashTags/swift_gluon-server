//
//  Vector.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation
import HugeNumbers

public class Vector : Hashable {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    public var x:HugeFloat
    public var y:HugeFloat
    public var z:HugeFloat
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
    
    public init(x: HugeFloat, y: HugeFloat, z: HugeFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}
