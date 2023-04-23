//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

public struct GluonChunk : Chunk {
    public let world:any World
    public let x:HugeInt
    public let z:HugeInt
    
    public var blocks:Set<Block>
    
    public init(world: any World, x: HugeInt, z: HugeInt) {
        self.world = world
        self.x = x
        self.z = z
        blocks = Set<Block>()
    }
}
