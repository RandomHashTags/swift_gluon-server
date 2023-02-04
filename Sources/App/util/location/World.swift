//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct World : Hashable {
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
}
