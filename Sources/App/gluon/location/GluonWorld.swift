//
//  GluonWorld.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

final class GluonWorld : World {
    let uuid:UUID
    let seed:Int64
    let name:String
    
    var spawn_location:Vector
    var difficulty:any Difficulty
    var game_rules:[any GameRule]
    var time:UInt64
    var border:WorldBorder?
    
    var y_min:Int
    var y_max:Int
    var y_sea_level:Int
    var chunks_loaded:[any Chunk]
    
    var allows_animals:Bool
    var allows_monsters:Bool
    var allows_pvp:Bool
    var beds_work:Bool
    
    var entities:[any Entity]
    var living_entities:[any LivingEntity]
    var players:[any Player]
    
    init(
        uuid: UUID,
        seed: Int64,
        name: String,
        spawn_location: Vector,
        difficulty: any Difficulty,
        game_rules: [any GameRule],
        time: UInt64,
        border: WorldBorder? = nil,
        y_min: Int,
        y_max: Int,
        y_sea_level: Int,
        chunks_loaded: [any Chunk],
        allows_animals: Bool,
        allows_monsters: Bool,
        allows_pvp: Bool,
        beds_work: Bool,
        entities: [any Entity],
        living_entities: [any LivingEntity],
        players: [any Player]
    ) {
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
    
    func load_chunk(x: Int, z: Int) async {
        let chunk:any Chunk = GluonChunk(world: self, x: x, z: z)
        guard chunks_loaded.first(where: { $0.x == x && $0.z == z }) == nil else { return }
        let event:GluonChunkLoadEvent = GluonChunkLoadEvent(chunk: chunk)
        GluonServer.shared.call_event(event: event)
        guard !event.isCancelled else { return }
        await chunk.load()
        chunks_loaded.append(chunk)
    }
    func unload_chunk(x: Int, z: Int) async {
        let chunk:any Chunk = GluonChunk(world: self, x: x, z: z)
        guard let index:Int = chunks_loaded.firstIndex(where: { $0.x == x && $0.z == z }) else { return }
        let event:GluonChunkUnloadEvent = GluonChunkUnloadEvent(chunk: chunk)
        GluonServer.shared.call_event(event: event)
        guard !event.isCancelled else { return }
        chunks_loaded.remove(at: index)
        await chunk.unload()
    }
}
