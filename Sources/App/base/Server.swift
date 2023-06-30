//
//  Server.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import HugeNumbers

public protocol Server : Tickable {
    var ticks_per_second : UInt8 { get }
    var ticks_per_second_multiplier : HugeFloat { get }
    var server_tick_interval_nano : UInt64 { get }
    var server_is_awake : Bool { get }
    var server_loop : Task<Void, Error>! { get }
    var gravity : HugeFloat { get }
    var gravity_per_tick : HugeFloat { get }
    var void_damage_per_tick : Double { get }
    var fire_damage_per_second : Double { get }
    
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
    mutating func wake_up()
    
    func call_event(event: some Event)
    
    func get_nearby_entities(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [any Entity]
    
    func get_entity(uuid: UUID) -> (any Entity)?
    func get_entities(uuids: Set<UUID>) -> [any Entity]
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)?
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity]
    
    func get_player(uuid: UUID) -> (any Player)?
    func get_players(uuids: Set<UUID>) -> [any Player]
}


public extension Server {
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
    mutating func register_event_type<T: EventType>(type: T) throws {
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
    func get_materials(identifiers: any Collection<String>) -> [any Material]? {
        let map:[any Material] = identifiers.compactMap({ materials[$0] })
        return map.isEmpty ? nil : map
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
    func get_recipes(identifiers: any Collection<String>) -> [any Recipe]? {
        let map:[any Recipe] = identifiers.compactMap({ recipes[$0] })
        return map.isEmpty ? nil : map
    }
}
