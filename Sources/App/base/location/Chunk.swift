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
    
    var world : TargetWorld { get }
    var x : HugeInt { get }
    var z : HugeInt { get }
    
    var blocks:Set<TargetBlock> { get set }
    
    init(world: TargetWorld, x: HugeInt, z: HugeInt)
    
    var entities : [TargetEntity] { get }
    var living_entities : [TargetLivingEntity] { get }
    var players : [TargetPlayer] { get }
    
    func load() async
    func unload()
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
    
    func load() async {
        let seed:Int64 = world.seed
    }
    func unload() {
        for player in players {
            player.save()
            player.remove()
        }
        for entity in entities {
            entity.save()
            entity.remove()
        }
        for living_entity in living_entities {
            living_entity.save()
            living_entity.remove()
        }
        
        save()
    }
}
