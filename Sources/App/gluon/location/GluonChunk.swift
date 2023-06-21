//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

struct GluonChunk : Chunk {
    typealias TargetWorld = GluonWorld
    typealias TargetBlock = GluonBlock
    
    typealias TargetEntity = GluonEntity
    typealias TargetLivingEntity = GluonLivingEntity
    typealias TargetPlayer = GluonPlayer
    
    var world:TargetWorld
    let x:HugeInt
    let z:HugeInt
    
    var blocks:Set<TargetBlock>
    
    var entities : [TargetEntity] {
        let entities:[TargetEntity] = world.entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var living_entities : [TargetLivingEntity] {
        let entities:[TargetLivingEntity] = world.living_entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var players : [TargetPlayer] {
        let entities:[TargetPlayer] = world.players
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    
    init(world: TargetWorld, x: HugeInt, z: HugeInt) {
        self.world = world
        self.x = x
        self.z = z
        blocks = Set<TargetBlock>()
    }
    
    mutating func tick(_ server: any Server) {
    }
}
