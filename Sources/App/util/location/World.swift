//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class World : Hashable {
    public static func == (lhs: World, rhs: World) -> Bool {
        return lhs.seed == rhs.seed && lhs.name.elementsEqual(rhs.name)
    }
    
    public let seed:UInt64
    public let name:String
    
    public var spawn_location:(x: Float, y: Float, z: Float, yaw: Float, pitch: Float)
    public var difficulty:UnsafePointer<Difficulty>
    
    public var y_min:Int64
    public var y_max:Int64
    public var y_sea_level:Int64
    
    public var chunks_loaded:Set<Chunk>
    
    var allows_animals:Bool
    var allows_monsters:Bool
    var allows_pvp:Bool
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(seed)
        hasher.combine(name)
    }
    
    public init(seed: UInt64, name: String, spawn_location: (x: Float, y: Float, z: Float, yaw: Float, pitch: Float), difficulty: UnsafePointer<Difficulty>, y_min: Int64, y_max: Int64, y_sea_level: Int64, chunks_loaded: Set<Chunk>, allows_animals: Bool, allows_monsters: Bool, allows_pvp: Bool) {
        self.seed = seed
        self.name = name
        self.spawn_location = spawn_location
        self.difficulty = difficulty
        self.y_min = y_min
        self.y_max = y_max
        self.y_sea_level = y_sea_level
        self.chunks_loaded = chunks_loaded
        self.allows_animals = allows_animals
        self.allows_monsters = allows_monsters
        self.allows_pvp = allows_pvp
    }
}
