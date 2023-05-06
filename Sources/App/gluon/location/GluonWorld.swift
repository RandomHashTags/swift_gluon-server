//
//  GluonWorld.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

struct GluonWorld : World {
    typealias TargetChunk = GluonChunk
    typealias TargetEntity = GluonEntity
    typealias TargetLivingEntity = GluonLivingEntity
    typealias TargetPlayer = GluonPlayer
    typealias TargetLocation = GluonLocation
    
    let uuid:UUID
    let seed:Int64
    let name:String
    
    var spawn_location:Vector
    var difficulty:Difficulty
    var game_rules:Set<GameRule>
    var time:UInt64
    var border:WorldBorder?
    
    var y_min:HugeFloat
    var y_max:HugeFloat
    var y_sea_level:HugeFloat
    var chunks_loaded:[TargetChunk]
    
    var allows_animals:Bool
    var allows_monsters:Bool
    var allows_pvp:Bool
    var beds_work:Bool
    
    var entities:[TargetEntity]
    var living_entities:[TargetLivingEntity]
    var players:[TargetPlayer]
    
    
    mutating func load_chunk(x: HugeInt, z: HugeInt) async {
        let chunk:TargetChunk = TargetChunk(world: self, x: x, z: z)
        guard chunks_loaded.firstIndex(of: chunk) == nil else { return }
        let event:GluonChunkLoadEvent = GluonChunkLoadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        await chunk.load()
        chunks_loaded.append(chunk)
    }
    mutating func unload_chunk(x: HugeInt, z: HugeInt) async {
        let chunk:TargetChunk = TargetChunk(world: self, x: x, z: z)
        guard let index:Int = chunks_loaded.firstIndex(of: chunk) else { return }
        let event:GluonChunkUnloadEvent = GluonChunkUnloadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        chunks_loaded.remove(at: index)
        chunk.unload()
    }
}
