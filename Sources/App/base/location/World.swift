//
//  World.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import HugeNumbers

public protocol World : AnyObject, Hashable, Tickable {
    var uuid : UUID { get }
    var seed : Int64 { get }
    var name : String { get }
    
    var spawn_location : Vector { get set }
    var difficulty : any Difficulty { get set }
    var game_rules : [any GameRule] { get set }
    var time : UInt64 { get set }
    var border : (any WorldBorder)? { get set }
    
    var y_min : HugeFloat { get set }
    var y_max : HugeFloat { get set }
    var y_sea_level : HugeFloat { get set }
    
    var chunks_loaded : [any Chunk] { get set }
    
    var allows_animals : Bool { get set }
    var allows_monsters : Bool { get set }
    var allows_pvp : Bool { get set }
    
    var beds_work : Bool { get set}
    
    var entities : [any Entity] { get set }
    var living_entities : [any LivingEntity] { get set }
    var players : [any Player] { get set }
    
    func equals(_ world: any World) -> Bool
    func load_chunk(x: HugeInt, z: HugeInt) async
    func unload_chunk(x: HugeInt, z: HugeInt) async
    
    func spawn_entity(_ entity: any Entity)
    func remove_entity(_ entity: any Entity)
    
    func spawn_living_entity(_ entity: any LivingEntity)
    func remove_living_entity(_ entity: any LivingEntity)
    
    func spawn_player(_ entity: any Player)
    func remove_player(_ entity: any Player)
    
    func get_nearby_entities(center: any Location, x: HugeFloat, y: HugeFloat, z: HugeFloat) -> [any Entity]
    func get_nearby_entities(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [any Entity]
    
    func get_entity(uuid: UUID) -> (any Entity)?
    func get_entities(uuids: Set<UUID>) -> [any Entity]
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)?
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity]
    
    func get_player(uuid: UUID) -> (any Player)?
    func get_players(uuids: Set<UUID>) -> [any Player]
}

public extension World {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.seed == rhs.seed && lhs.name.elementsEqual(rhs.name)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(seed)
        hasher.combine(name)
    }
    
    func equals(_ world: any World) -> Bool {
        return uuid == world.uuid && seed == world.seed && name.elementsEqual(world.name)
    }
    func tick(_ server: any Server) {
        for chunk in chunks_loaded {
            chunk.tick(server)
        }
        
        for entity in entities {
            entity.tick(server)
        }
        for entity in living_entities {
            entity.tick(server)
        }
        for entity in players {
            entity.tick(server)
        }
    }
    
    /*func save() {
        for chunk in chunks_loaded {
            chunk.save()
        }
        for entity in entities {
            entity.save()
        }
    }*/
}

public extension World {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        for entity in entities {
            entity.server_tps_slowed(to: tps, divisor: divisor)
        }
        for entity in living_entities {
            entity.server_tps_slowed(to: tps, divisor: divisor)
        }
        for entity in players {
            entity.server_tps_slowed(to: tps, divisor: divisor)
        }
        for chunk in chunks_loaded {
            chunk.server_tps_slowed(to: tps, divisor: divisor)
        }
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        for entity in entities {
            entity.server_tps_increased(to: tps, multiplier: multiplier)
        }
        for entity in living_entities {
            entity.server_tps_increased(to: tps, multiplier: multiplier)
        }
        for entity in players {
            entity.server_tps_increased(to: tps, multiplier: multiplier)
        }
        for chunk in chunks_loaded {
            chunk.server_tps_increased(to: tps, multiplier: multiplier)
        }
    }
}

public extension World {
    func spawn_entity(_ entity: any Entity) {
        entities.append(entity)
    }
    func remove_entity(_ entity: any Entity) {
        let entity_uuid:UUID = entity.uuid
        guard let index:Int = entities.firstIndex(where: { $0.uuid == entity_uuid }) else { return }
        entities.remove(at: index)
    }
    func spawn_living_entity(_ entity: any LivingEntity) {
        living_entities.append(entity)
    }
    func remove_living_entity(_ entity: any LivingEntity) {
        let entity_uuid:UUID = entity.uuid
        guard let index:Int = living_entities.firstIndex(where: { $0.uuid == entity_uuid }) else { return }
        living_entities.remove(at: index)
    }
    func spawn_player(_ player: any Player) {
        players.append(player)
    }
    func remove_player(_ player: any Player) {
        let player_uuid:UUID = player.uuid
        guard let index:Int = players.firstIndex(where: { $0.uuid == player_uuid }) else { return }
        players.remove(at: index)
    }
    
    func get_nearby_entities(center: any Location, x: HugeFloat, y: HugeFloat, z: HugeFloat) -> [any Entity] {
        return entities.filter({ $0.location.is_nearby(center: center, x_radius: x, y_radius: y, z_radius: z) })
    }
    func get_nearby_entities(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [any Entity] {
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
