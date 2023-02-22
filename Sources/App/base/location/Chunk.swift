//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Chunk : Jsonable, Tickable {
    public let world:World
    public let x:Int64
    public let z:Int64
    
    public var entities : [Entity] {
        let entities:Set<Entity> = world.entities
        let this_chunk:(Int64, Int64) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    public var living_entities : [LivingEntity] {
        let entities:Set<LivingEntity> = world.living_entities
        let this_chunk:(Int64, Int64) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }
    public var players : [Player] {
        let entities:Set<Player> = world.players
        let this_chunk:(Int64, Int64) = (x, z)
        return entities.filter({ $0.location.chunk_coordinates == this_chunk })
    }

    public func load() async {
        let seed:Int64 = world.seed
    }
    public func unload() {
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
    
    func save() {
    }
    public func tick(_ server: GluonServer) {
    }
}
