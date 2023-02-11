//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class World : Jsonable {
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
    
    internal var world_entities:Set<Entity> = Set<Entity>()
    public var entities : Set<Entity> {
        return world_entities
    }
    public var living_entities : [LivingEntity] {
        return world_entities.compactMap({ $0 as? LivingEntity })
    }
    public var players : [Player] {
        return world_entities.compactMap({ $0 as? Player })
    }
    
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
    }
    func tick() {
        for chunk in chunks_loaded {
            chunk.tick()
        }
        
        for entity in entities {
            entity.tick()
        }
    }
    
    func load_chunk(x: Int64, z: Int64) {
        guard chunks_loaded.first(where: { $0.x == x && $0.z == z }) == nil else { return }
    }
    func unload_chunk(x: Int64, z: Int64) {
    }
    
    func spawn_entity(_ entity: Entity) {
        world_entities.insert(entity)
    }
    
    public func get_nearby_entities(center: Location, x: Double, y: Double, z: Double) -> [Entity] {
        return world_entities.filter({ $0.location.is_nearby(center: center, x_radius: x, y_radius: y, z_radius: z) })
    }
    public func get_nearby_entities(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [Entity] {
        return world_entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    public func get_entity(uuid: UUID) -> Entity? {
        return world_entities.first(where: { $0.uuid == uuid })
    }
    public func get_entities(uuids: Set<UUID>) -> [Entity] {
        return world_entities.filter({ uuids.contains($0.uuid) })
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
