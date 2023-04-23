//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

public struct GluonChunk : Chunk {
    public typealias TargetWorld = GluonWorld
    public typealias TargetBlock = GluonBlock
    
    public typealias TargetEntity = GluonEntity
    public typealias TargetLivingEntity = GluonLivingEntity
    public typealias TargetPlayer = GluonPlayer
    
    public let world:TargetWorld
    public let x:HugeInt
    public let z:HugeInt
    
    public var blocks:Set<TargetBlock>
    
    public init(world: TargetWorld, x: HugeInt, z: HugeInt) {
        self.world = world
        self.x = x
        self.z = z
        blocks = Set<TargetBlock>()
    }
    
    public mutating func tick(_ server: any Server) {
    }
}
