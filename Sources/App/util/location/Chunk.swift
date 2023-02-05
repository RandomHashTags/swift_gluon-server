//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Chunk : Hashable {
    public static func == (lhs: Chunk, rhs: Chunk) -> Bool {
        return lhs.world == rhs.world && lhs.x == rhs.x && lhs.z == rhs.z
    }
    
    public let world:UnsafePointer<World>
    public let x:Int64
    public let z:Int64
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(world)
        hasher.combine(x)
        hasher.combine(z)
    }
    
    public init(world: UnsafePointer<World>, x: Int64, z: Int64) {
        self.world = world
        self.x = x
        self.z = z
    }
    
    public func load() async {
    }
    public func unload() {
    }
}
