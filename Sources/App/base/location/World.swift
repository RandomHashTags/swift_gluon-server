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
    
    public var y_min:Int64
    public var y_max:Int64
    public var y_sea_level:Int64
    
    public var chunks_loaded:Set<Chunk>
    
    public var allows_animals:Bool
    public var allows_monsters:Bool
    public var allows_pvp:Bool
    
    public var players:Set<UUID>
    
    func save() {
    }
}
