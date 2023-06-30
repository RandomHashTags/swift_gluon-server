//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

final class GluonChunk : Chunk {
    let world:any World
    let x:HugeInt
    let z:HugeInt
    
    var blocks:[any Block]
    
    var entities : [any Entity] {
        let entities:[any Entity] = world.entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var living_entities : [any LivingEntity] {
        let entities:[any LivingEntity] = world.living_entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var players : [any Player] {
        let entities:[any Player] = world.players
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    
    init(world: any World, x: HugeInt, z: HugeInt) {
        self.world = world
        self.x = x
        self.z = z
        blocks = []
    }
    
    func tick(_ server: any Server) {
    }
    
    func load() async {
    }
    func unload() async {
    }
}
