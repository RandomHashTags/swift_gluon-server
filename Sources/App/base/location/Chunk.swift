//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public protocol Chunk : Jsonable, Tickable, Saveable {
    var world : any World { get }
    var x : HugeInt { get }
    var z : HugeInt { get }
    
    var blocks:Set<Block> { get set }
    
    init(world: any World, x: HugeInt, z: HugeInt)
    
    var entities : [any Entity] { get }
    var living_entities : [any LivingEntity] { get }
    var players : [any Player] { get }
    
    func load() async
    func unload()
}

public extension Chunk {
    static func == (lhs: any Chunk, rhs: any Chunk) -> Bool {
        return lhs.world == rhs.world && lhs.x == rhs.x && lhs.z == rhs.z
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(world)
        hasher.combine(x)
        hasher.combine(z)
    }
    
    var entities : [any Entity] {
        let entities:Set<Entity> = world.entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var living_entities : [any LivingEntity] {
        let entities:Set<LivingEntity> = world.living_entities
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    var players : [any Player] {
        let entities:Set<any Player> = world.players
        let this_chunk:(HugeInt, HugeInt) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    
    mutating func tick(_ server: GluonServer) {
    }
    func save() {
    }
    
    func load() async {
        let seed:Int64 = world.seed
    }
    func unload() {
        for entity in entities {
            entity.save()
            entity.remove()
        }
        for living_entity in living_entities {
            living_entity.save()
            living_entity.remove()
        }
        for player in players {
            player.save()
            player.remove()
        }
        
        save()
    }
}
