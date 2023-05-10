//
//  Server.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation
import huge_numbers

public protocol Server : Tickable, Saveable {
    associatedtype TargetWorld : World
    associatedtype TargetEventType : EventType
    associatedtype TargetLocation : Location
    associatedtype TargetEntity : Entity
    associatedtype TargetLivingEntity : LivingEntity
    associatedtype TargetPlayer : Player
    associatedtype TargetMaterial : Material
    associatedtype TargetInventoryType : InventoryType
    associatedtype TargetGameMode : GameMode
    associatedtype TargetStatistic : Statistic
    associatedtype TargetRecipe : Recipe
    
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
    
    var difficulties : [String:Difficulty] { get set }
    var worlds : [String:TargetWorld] { get set }
    
    var event_types : [String:TargetEventType] { get set }
    
    var sound_categories : Set<SoundCategory> { get set }
    var sounds : Set<Sound> { get set }
    var materials : [String:TargetMaterial] { get set }
    var biomes : Set<Biome> { get set }
    var enchantment_types : [String:EnchantmentType] { get set }
    var entity_types : [String:EntityType] { get set }
    var inventory_types : [String:TargetInventoryType] { get set }
    var potion_effect_types : [String:PotionEffectType] { get set }
    var game_modes : [String:TargetGameMode] { get set }
    var advancements : [String:Advancement] { get set }
    var art : Set<Art> { get set }
    var attributes : Set<Attribute> { get set }
    var instruments : Set<Instrument> { get set }
    var statistics : [String:TargetStatistic] { get set }
    var commands : [String:Command] { get set }
    var permissions : [String:Permission] { get set }
    var recipes : [String:TargetRecipe] { get set }
    
    var event_listeners : [String:[any EventListener]] { get set }
    
    func set_tick_rate(ticks_per_second: UInt8)
    mutating func wake_up()
    
    func call_event(event: some Event)
    
    func get_nearby_entities(center: TargetLocation, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [TargetEntity]
    
    func get_entity(uuid: UUID) -> TargetEntity?
    func get_entities(uuids: Set<UUID>) -> [TargetEntity]
    
    func get_living_entity(uuid: UUID) -> TargetLivingEntity?
    func get_living_entities(uuids: Set<UUID>) -> [TargetLivingEntity]
    
    func get_player(uuid: UUID) -> TargetPlayer?
    func get_players(uuids: Set<UUID>) -> [TargetPlayer]
}


public extension Server {
    func call_event(event: some Event) {
        guard let event_listeners:[any EventListener] = event_listeners[event.type.identifier] else { return }
        for listener in event_listeners {
            listener.handle(event: event)
        }
    }
}

public extension Server {
    func get_event_type(identifier: String) -> TargetEventType? {
        return event_types[identifier]
    }
    mutating func register_event_type(type: TargetEventType) throws {
        event_types[type.identifier] = type
    }
    
    func get_entity_type(identifier: String) -> EntityType? {
        return entity_types[identifier]
    }
    func get_world(name: String) -> TargetWorld? {
        return worlds[name]
    }
    
    
    func get_advancement(identifier: String) -> Advancement? {
        return advancements[identifier]
    }
    func get_command(identifier: String) -> Command? {
        return commands[identifier]
    }
    func get_enchantment_type(identifier: String) -> EnchantmentType? {
        return enchantment_types[identifier]
    }
    func get_game_mode(identifier: String) -> TargetGameMode? {
        return game_modes[identifier]
    }
    func get_inventory_type(identifier: String) -> TargetInventoryType? {
        return inventory_types[identifier]
    }
    
    func get_material(identifier: String) -> TargetMaterial? {
        return materials[identifier]
    }
    func get_materials(identifiers: any Collection<String>) -> Set<TargetMaterial>? {
        let map:[TargetMaterial] = identifiers.compactMap({ materials[$0] })
        return map.isEmpty ? nil : Set<TargetMaterial>(map)
    }
    
    func get_permission(identifier: String) -> Permission? {
        return permissions[identifier]
    }
    func get_potion_effect_type(identifier: String) -> PotionEffectType? {
        return potion_effect_types[identifier]
    }
    func get_statistic(identifier: String) -> TargetStatistic? {
        return statistics[identifier]
    }
    
    func get_recipe(identifier: String) -> TargetRecipe? {
        return recipes[identifier]
    }
    func get_recipes(identifiers: any Collection<String>) -> Set<TargetRecipe>? {
        let map:[TargetRecipe] = identifiers.compactMap({ recipes[$0] })
        return map.isEmpty ? nil : Set<TargetRecipe>(map)
    }
}
