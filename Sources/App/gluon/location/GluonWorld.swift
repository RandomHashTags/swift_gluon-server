//
//  GluonWorld.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

public struct GluonWorld : World {
    public typealias TargetChunk = GluonChunk
    
    public let uuid:UUID
    public let seed:Int64
    public let name:String
    
    public var spawn_location:Vector
    public var difficulty:Difficulty
    public var game_rules:Set<GameRule>
    public var time:UInt64
    public var border:WorldBorder?
    
    public var y_min:HugeFloat
    public var y_max:HugeFloat
    public var y_sea_level:HugeFloat
    public var chunks_loaded:Set<GluonChunk>
    
    public var allows_animals:Bool
    public var allows_monsters:Bool
    public var allows_pvp:Bool
    public var beds_work:Bool
    
    
    public mutating func load_chunk(x: HugeInt, z: HugeInt) async {
        let chunk:GluonChunk = GluonChunk(world: self, x: x, z: z)
        guard !chunks_loaded.contains(chunk) else { return }
        await chunk.load()
        chunks_loaded.insert(chunk)
        let event:ChunkLoadEvent = ChunkLoadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
    }
    public mutating func unload_chunk(x: HugeInt, z: HugeInt) async {
        let chunk:GluonChunk = GluonChunk(world: self, x: x, z: z)
        guard chunks_loaded.contains(chunk) else { return }
        let event:ChunkUnloadEvent = ChunkUnloadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        chunks_loaded.remove(chunk)
        chunk.unload()
    }
}
