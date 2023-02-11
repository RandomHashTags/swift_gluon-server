//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public final class GluonServer : GluonSharedInstance {
    private var server_ticks_per_second:UInt8
    private var server_ticks_per_second_multiplier:Float
    private var server_tick_interval_nano:UInt64
    private var server_is_awake:Bool
    private var server_loop:Task<Void, Error>!
    private let server_gravity:Float
    private var server_gravity_per_tick:Float
    private var server_void_damage_per_tick:Float
    
    private var max_players:UInt64
    private var port:Int
    private var has_whitelist:Bool
    private var whitelisted_players:Set<UUID>
    private var banned_players:Set<BanEntry>
    private var banned_ip_addresses:Set<BanEntry>
    
    private var difficulties:Set<Difficulty>
    private var worlds:Set<World>
    
    private var sound_categories:Set<SoundCategory>
    private var sounds:Set<Sound>
    private var materials:Set<Material>
    private var biomes:Set<Biome>
    private var enchantment_types:Set<EnchantmentType>
    private var entity_types:Set<EntityType>
    private var inventory_types:Set<InventoryType>
    private var potion_effect_types:Set<PotionEffectType>
    private var game_modes:Set<GameMode>
    private var advancements:Set<Advancement>
    private var art:Set<Art>
    private var attributes:Set<Attribute>
    private var instruments:Set<Instrument>
    private var statistics:Set<Statistic>
    private var commands:Set<Command>
    private var permissions:Set<Permission>
    
    private var server_entities:Set<Entity>
    public var entities : Set<Entity> {
        return server_entities
    }
    public var living_entities : [LivingEntity] {
        return server_entities.compactMap({ $0 as? LivingEntity })
    }
    private var players : [Player] {
        return server_entities.compactMap({ $0 as? Player })
    }
    
    private var event_listeners:[any EventListener]
    
    convenience init() {
        self.init(ticks_per_second: 1)
    }
    private init(ticks_per_second: UInt8) {
        let ticks_per_second_float:Float = Float(ticks_per_second)
        server_ticks_per_second = ticks_per_second
        server_ticks_per_second_multiplier = ticks_per_second_float / 20
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_is_awake = false
        let gravity:Float = 9.8
        self.server_gravity = gravity
        server_gravity_per_tick = gravity / ticks_per_second_float
        server_void_damage_per_tick = 1 / ticks_per_second_float
        
        print("server_ticks_per_second=" + ticks_per_second.description + "; 1 every " + ((1000 / Int(ticks_per_second)).description + " milliseconds"))
        
        max_players = 1
        port = 25565
        has_whitelist = false
        whitelisted_players = []
        banned_players = []
        banned_ip_addresses = []
        
        difficulties = [
            Difficulty(identifier: "minecraft.survival")
        ]
        let spawn_location:Vector = Vector(x: 0, y: 0, z: 0)
        worlds = [
            World(
                uuid: UUID(),
                seed: 0,
                name: "world",
                spawn_location: spawn_location,
                difficulty: difficulties.first!,
                game_rules: [],
                time: 0,
                border: nil,
                y_min: -64,
                y_max: 320,
                y_sea_level: 100,
                chunks_loaded: [],
                allows_animals: true,
                allows_monsters: true,
                allows_pvp: true,
                beds_work: true,
                entities: [],
                living_entities: [],
                players: []
            )
        ]
        
        sound_categories = []
        sounds = []
        materials = []
        biomes = []
        enchantment_types = []
        entity_types = [
            EntityType(identifier: "minecraft.player", is_affected_by_gravity: true, is_damageable: true, receives_fall_damage: true, no_damage_ticks_maximum: 20, fire_ticks_maximum: 20, freeze_ticks_maximum: 20)
        ]
        inventory_types = [
        ]
        potion_effect_types = []
        game_modes = [
            GameMode(identifier: "minecraft.survival", allows_flight: false, can_break_blocks: true, can_breathe_underwater: false, can_pickup_items: true, can_place_blocks: true, is_affected_by_gravity: true, is_damageable: true, is_invisible: false, loses_hunger: true)
        ]
        advancements = []
        art = []
        attributes = []
        instruments = []
        statistics = []
        commands = []
        permissions = []
        
        server_entities = []
        
        event_listeners = []
    }
    
    func player_joined() {
        let inventory_type:InventoryType = InventoryType(identifier: "minecraft.player_items", size: 36)
        let inventory:Inventory = Inventory(type: inventory_type, items: [], viewers: [])
        let player:Player = Player(uuid: UUID(), name: "RandomHashTags", list_name: "RandomHashTags", custom_name: nil, display_name: nil, experience: 0, experience_level: 0, food_level: 10, permissions: [], statistics: [], game_mode: game_modes.first!, is_blocking: false, is_flying: false, is_op: true, is_sneaking: false, is_sprinting: false, inventory: inventory)
        server_entities.insert(player)
        call_event(event: PlayerJoinEvent(player: player))
        
        if !server_is_awake {
            wake_up()
        }
    }
    private func wake_up() {
        server_is_awake = true
        server_loop = Task {
            do {
                while server_is_awake {
                    tick()
                    
                    try await Task.sleep(nanoseconds: server_tick_interval_nano)
                }
            } catch {
                print("encountered error during server loop: \(error)")
            }
        }
    }
    func set_tick_rate(ticks_per_second: UInt8) {
        self.server_ticks_per_second = ticks_per_second
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_gravity_per_tick = server_gravity / Float(ticks_per_second)
    }
    
    private func save() {
        for world in worlds {
            world.save()
        }
        for entity in server_entities {
            entity.save()
        }
    }
    private func tick() {
        for entity in server_entities {
            entity.tick()
        }
    }
}

public extension GluonServer {
    var ticks_per_second : UInt8 { server_ticks_per_second }
    var ticks_per_second_multiplier : Float { server_ticks_per_second_multiplier }
    var gravity_per_tick : Float { server_gravity_per_tick }
    var void_damage_per_tick : Float { server_void_damage_per_tick }
}

public extension GluonServer {
    static func get_entity_type(identifier: String) -> EntityType? {
        return shared_instance.entity_types.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_world(name: String) -> World? {
        return shared_instance.worlds.first(where: { $0.name.elementsEqual(name) })
    }
    
    
    static func get_advancement(identifier: String) -> Advancement? {
        return shared_instance.advancements.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_command(identifier: String) -> Command? {
        return shared_instance.commands.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_material(identifier: String) -> Material? {
        return shared_instance.materials.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_permission(identifier: String) -> Permission? {
        return shared_instance.permissions.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_statistic(identifier: String) -> Statistic? {
        return shared_instance.statistics.first(where: { $0.identifier.elementsEqual(identifier) })
    }
}
public extension GluonServer {
    static func get_nearby_entities(location: Location, x_radius: Float, y_radius: Float, z_radius: Float) -> [Entity] {
        return GluonServer.shared_instance.server_entities.filter({ location.is_nearby($0.location, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    static func get_entity(uuid: UUID) -> Entity? {
        return GluonServer.shared_instance.server_entities.first(where: { $0.uuid == uuid })
    }
    static func get_entities(uuids: Set<UUID>) -> [Entity] {
        return GluonServer.shared_instance.server_entities.filter({ uuids.contains($0.uuid) })
    }
    
    static func get_living_entity(uuid: UUID) -> LivingEntity? {
        return GluonServer.shared_instance.living_entities.first(where: { $0.uuid == uuid })
    }
    static func get_living_entities(uuids: Set<UUID>) -> [LivingEntity] {
        return GluonServer.shared_instance.living_entities.filter({ uuids.contains($0.uuid) })
    }
    
    static func get_player(uuid: UUID) -> Player? {
        return GluonServer.shared_instance.players.first(where: { $0.uuid == uuid })
    }
    static func get_players(uuids: Set<UUID>) -> [Player] {
        return GluonServer.shared_instance.players.filter({ uuids.contains($0.uuid) })
    }
}

public extension GluonServer {
    static func boot_player(player: Player, reason: String, ban_user: Bool = false, ban_user_expiration: UInt64? = nil, ban_ip: Bool = false, ban_ip_expiration: UInt64? = nil) {
        let instance:GluonServer = GluonServer.shared_instance
        instance.server_entities.remove(player)
        
        if ban_user {
            instance.banned_players.insert(BanEntry(target: player.uuid.uuidString, ban_time: 0, expiration: ban_user_expiration, reason: reason))
        }
        if ban_ip {
            instance.banned_ip_addresses.insert(BanEntry(target: "PLAYER_IP_ADDRESS", ban_time: 0, expiration: ban_ip_expiration, reason: reason))
        }
        // TODO: send packets
    }
}

public extension GluonServer {
    func call_event(event: Event) {
        for listener in event_listeners {
            listener.handle(event: event)
        }
    }
}
