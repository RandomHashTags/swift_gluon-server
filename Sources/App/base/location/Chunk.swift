//
//  Chunk.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public protocol Chunk : Jsonable, Tickable, Saveable {
    associatedtype TargetWorld : World
    associatedtype TargetBlock : Block
    associatedtype TargetEntity : Entity
    associatedtype TargetLivingEntity : LivingEntity
    associatedtype TargetPlayer : Player
    
    var world : TargetWorld { get set }
    var x : HugeInt { get }
    var z : HugeInt { get }
    
    var blocks:Set<TargetBlock> { get set }
    
    init(world: TargetWorld, x: HugeInt, z: HugeInt)
    
    var entities : [TargetEntity] { get }
    var living_entities : [TargetLivingEntity] { get }
    var players : [TargetPlayer] { get }
    
    mutating func load() async
    mutating func unload() async
}

public extension Chunk {
    static func == (lhs: any Chunk, rhs: any Chunk) -> Bool {
        return lhs.world.equals(rhs.world) && lhs.x == rhs.x && lhs.z == rhs.z
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(world)
        hasher.combine(x)
        hasher.combine(z)
    }
    
    func save() {
    }
    
    mutating func load() async {
        let seed:Int64 = world.seed
    }
    mutating func unload() async {
        save()
        
        for index in world.entities.indices {
            world.entities[index].save()
        }
        for index in world.living_entities.indices {
            world.living_entities[index].save()
        }
        for index in world.players.indices {
            world.players[index].save()
        }
        
        for index in world.entities.indices {
            world.entities[index].remove()
        }
        for index in world.living_entities.indices {
            world.living_entities[index].remove()
        }
        for index in world.players.indices {
            world.players[index].remove()
        }
        
    }
}
