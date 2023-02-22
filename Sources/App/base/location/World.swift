//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class World : Jsonable, Tickable {
    public static func == (lhs: World, rhs: World) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.seed == rhs.seed && lhs.name.elementsEqual(rhs.name)
    }
    
    public let uuid:UUID
    public let seed:Int64
    public let name:String
    
    public var spawn_location:Vector
    public var difficulty:Difficulty
    public var game_rules:Set<GameRule>
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
    
    public internal(set) var entities:Set<Entity> = Set<Entity>()
    public internal(set) var living_entities:Set<LivingEntity> = Set<LivingEntity>()
    public internal(set) var players:Set<Player> = Set<Player>()
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(seed)
        hasher.combine(name)
    }
    
    public init(
        uuid: UUID,
        seed: Int64,
        name: String,
        spawn_location: Vector,
        difficulty: Difficulty,
        game_rules: Set<GameRule>,
        time: UInt64,
        border: WorldBorder? = nil,
        y_min: Int64,
        y_max: Int64,
        y_sea_level: Int64,
        chunks_loaded: Set<Chunk>,
        allows_animals: Bool,
        allows_monsters: Bool,
        allows_pvp: Bool,
        beds_work: Bool
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
    }
    
    func save() {
        for chunk in chunks_loaded {
            chunk.save()
        }
        for entity in entities {
            entity.save()
        }
    }
    public func tick(_ server: GluonServer) {
        for chunk in chunks_loaded {
            chunk.tick(server)
        }
        
        for entity in entities {
            entity.tick(server)
        }
    }
    
    func load_chunk(x: Int64, z: Int64) async {
        let chunk:Chunk = Chunk(world: self, x: x, z: z)
        guard !chunks_loaded.contains(chunk) else { return }
        await chunk.load()
        chunks_loaded.insert(chunk)
        let event:ChunkLoadEvent = ChunkLoadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
    }
    func unload_chunk(x: Int64, z: Int64) {
        let chunk:Chunk = Chunk(world: self, x: x, z: z)
        guard chunks_loaded.contains(chunk) else { return }
        let event:ChunkUnloadEvent = ChunkUnloadEvent(chunk: chunk)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        chunks_loaded.remove(chunk)
        chunk.unload()
    }
    
    public func spawn_entity(_ entity: Entity) {
        entities.insert(entity)
    }
    public func remove_entity(_ entity: Entity) {
        entities.remove(entity)
    }
    
    public func get_nearby_entities(center: Location, x: Double, y: Double, z: Double) -> [Entity] {
        return entities.filter({ $0.location.is_nearby(center: center, x_radius: x, y_radius: y, z_radius: z) })
    }
    public func get_nearby_entities(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [Entity] {
        return entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    public func get_entity(uuid: UUID) -> Entity? {
        return entities.first(where: { $0.uuid == uuid })
    }
    public func get_entities(uuids: Set<UUID>) -> [Entity] {
        return entities.filter({ uuids.contains($0.uuid) })
    }
    
    public func get_living_entity(uuid: UUID) -> LivingEntity? {
        return living_entities.first(where: { $0.uuid == uuid })
    }
    public func get_living_entities(uuids: Set<UUID>) -> [LivingEntity] {
        return living_entities.filter({ uuids.contains($0.uuid) })
    }
    
    public func get_player(uuid: UUID) -> Player? {
        return players.first(where: { $0.uuid == uuid })
    }
    public func get_players(uuids: Set<UUID>) -> [Player] {
        return players.filter({ uuids.contains($0.uuid) })
    }
}
