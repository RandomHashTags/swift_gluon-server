//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct World : Jsonable {
    public let seed:UInt64
    public let name:String
    
    public var spawn_location:Vector
    public var difficulty:Difficulty
    public var game_rules:Set<GameRuleActive>
    public var time:UInt64
    public var border:WorldBorder?
    
    public var y_min:Int64
    public var y_max:Int64
    public var y_sea_level:Int64
    
    public var chunks_loaded:Set<Chunk>
    
    public var allows_animals:Bool
    public var allows_monsters:Bool
    public var allows_pvp:Bool
    
    public var beds_work:Bool
    
    public var entities:Set<UUID>
    public var living_entities:Set<UUID>
    public var players:Set<UUID>
    
    func save() {
    }
    
    func load_chunk(x: Int64, z: Int64) {
        guard chunks_loaded.first(where: { $0.x == x && $0.z == z }) == nil else { return }
    }
    func unload_chunk(x: Int64, z: Int64) {
    }
    
    public func get_nearby_entities(x: Double, y: Double, z: Double) -> Set<Entity> {
        var entities:Set<Entity> = []
        return entities
    }
}
