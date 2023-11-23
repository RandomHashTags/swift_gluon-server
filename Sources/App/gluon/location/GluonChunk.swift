//
//  GluonChunk.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

final class GluonChunk : Chunk {
    let world:any World
    let x:Int
    let z:Int
    
    var blocks:[any Block]
    
    var entities : [any Entity] {
        let entities:[any Entity] = world.entities
        let this_chunk:(Int, Int) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var living_entities : [any LivingEntity] {
        let entities:[any LivingEntity] = world.living_entities
        let this_chunk:(Int, Int) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var players : [any Player] {
        let entities:[any Player] = world.players
        let this_chunk:(Int, Int) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    
    init(world: any World, x: Int, z: Int) {
        self.world = world
        self.x = x
        self.z = z
        blocks = []
    }
    
    func load() async {
    }
    func unload() async {
    }
}
