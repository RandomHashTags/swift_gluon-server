//
//  GluonWorld.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

final class GluonWorld : World {
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
    
    init(uuid: UUID, seed: Int64, name: String, spawn_location: Vector, difficulty: Difficulty, game_rules: Set<GameRule>, time: UInt64, border: WorldBorder? = nil, y_min: HugeFloat, y_max: HugeFloat, y_sea_level: HugeFloat, chunks_loaded: [TargetChunk], allows_animals: Bool, allows_monsters: Bool, allows_pvp: Bool, beds_work: Bool, entities: [TargetEntity], living_entities: [TargetLivingEntity], players: [TargetPlayer]) {
        self.uuid = uuid
        self.seed = seed
        self.name = name
        self.spawn_location = spawn_location
        self.difficulty = difficulty
        self.game_rules = game_rules
        self.time = time
        self.border = border
        self.y_min = y_min
        self.y_max = y_max
        self.y_sea_level = y_sea_level
        self.chunks_loaded = chunks_loaded
        self.allows_animals = allows_animals
        self.allows_monsters = allows_monsters
        self.allows_pvp = allows_pvp
        self.beds_work = beds_work
        self.entities = entities
        self.living_entities = living_entities
        self.players = players
    }
    
    func load_chunk(x: HugeInt, z: HugeInt) async {
        var chunk:TargetChunk = TargetChunk(world: self, x: x, z: z)
        guard chunks_loaded.firstIndex(of: chunk) == nil else { return }
        let event:GluonChunkLoadEvent = GluonChunkLoadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        await chunk.load()
        chunks_loaded.append(chunk)
    }
    func unload_chunk(x: HugeInt, z: HugeInt) async {
        var chunk:TargetChunk = TargetChunk(world: self, x: x, z: z)
        guard let index:Int = chunks_loaded.firstIndex(of: chunk) else { return }
        let event:GluonChunkUnloadEvent = GluonChunkUnloadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        chunks_loaded.remove(at: index)
        await chunk.unload()
    }
}
