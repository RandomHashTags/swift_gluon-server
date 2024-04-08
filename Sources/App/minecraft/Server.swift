//
//  Server.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

public protocol Server : AnyObject, Tickable {
    
    var chat_manager : ChatManager { get }
    var version : SemanticVersion { get }
    
    var ticks_per_second : UInt8 { get }
    var ticks_per_second_multiplier : Double { get }
    var server_tick_interval_nano : UInt64 { get }
    var server_is_awake : Bool { get }
    var server_loop : Task<Void, Error>! { get }
    var gravity : Double { get }
    var gravity_per_tick : Double { get set }
    var void_damage_per_tick : Double { get set }
    var fire_damage_per_second : Double { get set }
    
    var max_players : UInt64 { get set }
    var port : Int { get }
    var has_whitelist : Bool { get set }
    var whitelisted_players : Set<UUID> { get set }
    var banned_players : Set<BanEntry> { get set }
    var banned_ip_addresses : Set<BanEntry> { get set }
    
    var difficulties : [String : any Difficulty] { get set }
    var worlds : [String : any World] { get set }
    
    var event_types : [String : any EventType] { get set }
    
    var sound_categories : [String : any SoundCategory] { get set }
    var sounds : [String : any Sound] { get set }
    var materials : [String : any Material] { get set }
    var biomes : [String : any Biome] { get set }
    var enchantment_types : [String : any EnchantmentType] { get set }
    var entity_types : [String : any EntityType] { get set }
    var inventory_types : [String : any InventoryType] { get set }
    var potion_effect_types : [String : any PotionEffectType] { get set }
    var game_modes : [String : any GameMode] { get set }
    var advancements : [String : any Advancement] { get set }
    var art : [String : any Art] { get set }
    var attributes : [String : any Attribute] { get set }
    var instruments : [String : any Instrument] { get set }
    var statistics : [String : any Statistic] { get set }
    var commands : [String : any Command] { get set }
    var permissions : [String : any Permission] { get set }
    var recipes : [String : any Recipe] { get set }
    
    var event_listeners : [String : [any EventListener]] { get set }
    
    func set_tick_rate(ticks_per_second: UInt8)
    func wake_up()
    
    func call_event(event: some Event)
    
    func get_nearby_entities(center: any Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [any Entity]
    
    func get_entity(uuid: UUID) -> (any Entity)?
    func get_entities(uuids: Set<UUID>) -> [any Entity]
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)?
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity]
    
    func get_player(uuid: UUID) -> (any Player)?
    func get_players(uuids: Set<UUID>) -> [any Player]
}


public extension Server {
    var players : [any Player] {
        return ServerMojang.instance.player_connections.values.compactMap({ $0.player })
    }
    
    func tick(_ server: any Server) {
        for world in worlds.values {
            world.tick(server)
        }
    }
    
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        gravity_per_tick *= Double(divisor)
        void_damage_per_tick *= Double(divisor)
        
        for entity_type in entity_types.values {
            entity_type.server_tps_slowed(to: tps, divisor: divisor)
        }
        
        for material in materials.values {
            let configuration:any MaterialConfiguration = material.configuration
            if let test:any MaterialItemConsumableConfiguration = configuration.item?.consumable {
                test.server_tps_slowed(to: tps, divisor: divisor)
            }
            if let test:any MaterialBlockLiquidConfiguration = configuration.block?.liquid {
                test.server_tps_slowed(to: tps, divisor: divisor)
            }
        }
        
        for world in worlds.values {
            world.server_tps_slowed(to: tps, divisor: divisor)
        }
    }
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        gravity_per_tick /= Double(multiplier)
        void_damage_per_tick /= Double(multiplier)
        
        for entity_type in entity_types.values {
            entity_type.server_tps_increased(to: tps, multiplier: multiplier)
        }
        
        for material in materials.values {
            let configuration:any MaterialConfiguration = material.configuration
            if let test:any MaterialItemConsumableConfiguration = configuration.item?.consumable {
                test.server_tps_increased(to: tps, multiplier: multiplier)
            }
            if let test:any MaterialBlockLiquidConfiguration = configuration.block?.liquid {
                test.server_tps_increased(to: tps, multiplier: multiplier)
            }
        }
        
        for world in worlds.values {
            world.server_tps_increased(to: tps, multiplier: multiplier)
        }
    }
    
    func call_event(event: some Event) {
        guard let event_listeners:[any EventListener] = event_listeners[event.type.id] else { return }
        for listener in event_listeners {
            listener.handle(event: event)
        }
    }
}

public extension Server {
    func get_event_type(identifier: String) -> (any EventType)? {
        return event_types[identifier]
    }
    func register_event_type(type: any EventType) throws {
        event_types[type.id] = type
    }
    
    func get_entity_type(identifier: String) -> (any EntityType)? {
        return entity_types[identifier]
    }
    func get_world(name: String) -> (any World)? {
        return worlds[name]
    }
    
    
    func get_advancement(id: String) -> (any Advancement)? {
        return advancements[id]
    }
    func get_command(identifier: String) -> (any Command)? {
        return commands[identifier]
    }
    func get_enchantment_type(identifier: String) -> (any EnchantmentType)? {
        return enchantment_types[identifier]
    }
    func get_game_mode(identifier: String) -> (any GameMode)? {
        return game_modes[identifier]
    }
    func get_inventory_type(identifier: String) -> (any InventoryType)? {
        return inventory_types[identifier]
    }
    
    func get_material(identifier: String) -> (any Material)? {
        return materials[identifier]
    }
    func get_materials(identifiers: any Collection<String>) -> [any Material] {
        return identifiers.compactMap({ materials[$0] })
    }
    
    func get_permission(identifier: String) -> (any Permission)? {
        return permissions[identifier]
    }
    func get_potion_effect_type(identifier: String) -> (any PotionEffectType)? {
        return potion_effect_types[identifier]
    }
    func get_statistic(identifier: String) -> (any Statistic)? {
        return statistics[identifier]
    }
    
    func get_recipe(identifier: String) -> (any Recipe)? {
        return recipes[identifier]
    }
    func get_recipes(identifiers: any Collection<String>) -> [any Recipe] {
        return identifiers.compactMap({ recipes[$0] })
    }
    
    func get_instrument(identifier: String) -> (any Instrument)? {
        return instruments[identifier]
    }
}

public extension Server {
    func get_nearby_entities(center: any Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [any Entity] {
        return center.world.entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    func get_entity(uuid: UUID) -> (any Entity)? {
        for world in worlds.values {
            if let entity:any Entity = world.entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_entities(uuids: Set<UUID>) -> [any Entity] {
        return worlds.values.flatMap({ $0.entities.filter({ uuids.contains($0.uuid) }) })
    }
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)? {
        for world in worlds.values {
            if let entity:any LivingEntity = world.living_entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity] {
        return worlds.values.flatMap({ $0.living_entities.filter({ uuids.contains($0.uuid) }) })
    }
    
    func get_player(uuid: UUID) -> (any Player)? {
        return ServerMojang.instance.player_connections[uuid]?.player
    }
    func get_players(uuids: Set<UUID>) -> [any Player] {
        return worlds.values.flatMap({ $0.players.filter({ uuids.contains($0.uuid) }) })
    }
}
