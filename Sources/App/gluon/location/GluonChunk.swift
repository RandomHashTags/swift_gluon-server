//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

struct GluonChunk : Chunk {
    typealias TargetWorld = GluonWorld
    typealias TargetBlock = GluonBlock
    
    typealias TargetEntity = GluonEntity
    typealias TargetLivingEntity = GluonLivingEntity
    typealias TargetPlayer = GluonPlayer
    
    let world:TargetWorld
    let x:HugeInt
    let z:HugeInt
    
    var blocks:Set<TargetBlock>
    
    init(world: TargetWorld, x: HugeInt, z: HugeInt) {
        self.world = world
        self.x = x
        self.z = z
        blocks = Set<TargetBlock>()
    }
    
    mutating func tick(_ server: any Server) {
    }
}
