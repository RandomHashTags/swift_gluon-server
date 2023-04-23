//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public protocol World : Jsonable, Tickable {
    var uuid : UUID { get }
    var seed : Int64 { get }
    var name : String { get }
    
    var spawn_location : Vector { get set }
    var difficulty : Difficulty { get set }
    var game_rules : Set<GameRule> { get set }
    var time : UInt64 { get set }
    var border : WorldBorder? { get set }
    
    var y_min : HugeInt { get set }
    var y_max : HugeInt { get set }
    var y_sea_level : HugeInt { get set }
    
    var chunks_loaded : Set<Chunk> { get set }
    
    var allows_animals : Bool { get set }
    var allows_monsters : Bool { get set }
    var allows_pvp : Bool { get set }
    
    var beds_work : Bool { get set}
    
    var entities : Set<Entity> { get }
    var living_entities : Set<LivingEntity> { get }
    var players : Set<Player> { get }
    
    mutating func load_chunk(x: Int64, z: Int64) async
    mutating func unload_chunk(x: Int64, z: Int64) async
    
    func spawn_entity(_ entity: any Entity)
    func remove_entity(_ entity: any Entity)
    
    func get_nearby_entities(center: Location, x: Double, y: Double, z: Double) -> [any Entity]
    func get_nearby_entities(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [any Entity]
    
    func get_entity(uuid: UUID) -> (any Entity)?
    func get_entities(uuids: Set<UUID>) -> [any Entity]
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)?
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity]
    
    func get_player(uuid: UUID) -> (any Player)?
    func get_players(uuids: Set<UUID>) -> [any Player]
}

public extension World {
    static func == (lhs: any World, rhs: any World) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.seed == rhs.seed && lhs.name.elementsEqual(rhs.name)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(seed)
        hasher.combine(name)
    }
    
    mutating func tick(_ server: GluonServer) {
        for chunk in chunks_loaded {
            chunk.tick(server)
        }
        
        for entity in entities {
            entity.tick(server)
        }
    }
    
    func save() {
        for chunk in chunks_loaded {
            chunk.save()
        }
        for entity in entities {
            entity.save()
        }
    }
    
    func spawn_entity(_ entity: any Entity) {
        entities.insert(entity)
    }
    func remove_entity(_ entity: any Entity) {
        entities.remove(entity)
    }
    
    func get_nearby_entities(center: Location, x: Double, y: Double, z: Double) -> [any Entity] {
        return entities.filter({ $0.location.is_nearby(center: center, x_radius: x, y_radius: y, z_radius: z) })
    }
    func get_nearby_entities(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [any Entity] {
        return entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    func get_entity(uuid: UUID) -> (any Entity)? {
        return entities.first(where: { $0.uuid == uuid })
    }
    func get_entities(uuids: Set<UUID>) -> [any Entity] {
        return entities.filter({ uuids.contains($0.uuid) })
    }
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)? {
        return living_entities.first(where: { $0.uuid == uuid })
    }
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity] {
        return living_entities.filter({ uuids.contains($0.uuid) })
    }
    
    func get_player(uuid: UUID) -> (any Player)? {
        return players.first(where: { $0.uuid == uuid })
    }
    func get_players(uuids: Set<UUID>) -> [any Player] {
        return players.filter({ uuids.contains($0.uuid) })
    }
}
