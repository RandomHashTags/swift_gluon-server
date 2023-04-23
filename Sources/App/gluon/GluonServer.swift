//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

public final class GluonServer : GluonSharedInstance, Server {
    public var ticks_per_second:UInt8
    public var ticks_per_second_multiplier:Double
    public var server_tick_interval_nano:UInt64
    public var server_is_awake:Bool
    public var server_loop:Task<Void, Error>!
    public var gravity:Double
    public var gravity_per_tick:Double
    public var void_damage_per_tick:Double
    
    public var max_players:UInt64
    public var port:Int
    public var has_whitelist:Bool
    public var whitelisted_players:Set<UUID>
    public var banned_players:Set<BanEntry>
    public var banned_ip_addresses:Set<BanEntry>
    
    public var difficulties:[String:Difficulty]
    public var worlds:[String:any World]
    
    public var event_types:[String:EventType]
    
    public var sound_categories:Set<SoundCategory>
    public var sounds:Set<Sound>
    public var materials:[String:Material]
    public var biomes:Set<Biome>
    public var enchantment_types:[String:EnchantmentType]
    public var entity_types:[String:EntityType]
    public var inventory_types:Set<InventoryType>
    public var potion_effect_types:[String:PotionEffectType]
    public var game_modes:[String:GameMode]
    public var advancements:[String:Advancement]
    public var art:Set<Art>
    public var attributes:Set<Attribute>
    public var instruments:Set<Instrument>
    public var statistics:Set<Statistic>
    public var commands:[String:Command]
    public var permissions:[String:Permission]
    public var recipes:[String:Recipe]
    
    public var event_listeners:[String:[any EventListener]]
    
    convenience init() {
        self.init(ticks_per_second: 1)
    }
    private init(ticks_per_second: UInt8) {
        let ticks_per_second_float:Double = Double(ticks_per_second)
        self.ticks_per_second = ticks_per_second
        ticks_per_second_multiplier = ticks_per_second_float / 20
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_is_awake = false
        let gravity:Double = 9.80665
        self.gravity = gravity
        gravity_per_tick = gravity / ticks_per_second_float
        void_damage_per_tick = 1 / ticks_per_second_float
        
        print("server_ticks_per_second=" + ticks_per_second.description + "; 1 every " + ((1000 / Int(ticks_per_second)).description + " milliseconds"))
        
        max_players = 1
        port = 25565
        has_whitelist = false
        whitelisted_players = []
        banned_players = []
        banned_ip_addresses = []
        
        difficulties = [
            "minecraft.normal" : Difficulty(identifier: "minecraft.normal", name: MultilingualStrings(english: "Normal"))
        ]
        let spawn_location:Vector = Vector(x: 0, y: 0, z: 0)
        worlds = [
            "overworld" : GluonWorld(
                uuid: UUID(),
                seed: 0,
                name: "overworld",
                spawn_location: spawn_location,
                difficulty: difficulties.first!.value,
                game_rules: [],
                time: 0,
                border: nil,
                y_min: HugeInt("-64"),
                y_max: HugeInt("320"),
                y_sea_level: HugeInt("100"),
                chunks_loaded: [],
                allows_animals: true,
                allows_monsters: true,
                allows_pvp: true,
                beds_work: true
            )
        ]
        
        event_types = [:]
        
        sound_categories = []
        sounds = []
        materials = [:]
        biomes = []
        enchantment_types = [:]
        entity_types = [
            "minecraft.player" : EntityType(identifier: "minecraft.player", name: MultilingualStrings(english: "Player"), is_affected_by_gravity: true, is_damageable: true, receives_fall_damage: true, no_damage_ticks_maximum: 20, fire_ticks_maximum: 20, freeze_ticks_maximum: 20)
        ]
        inventory_types = [
        ]
        potion_effect_types = [:]
        game_modes = [
            "minecraft.survival" : GameMode(identifier: "minecraft.survival", name: MultilingualStrings(english: "Survival"), allows_flight: false, can_break_blocks: true, can_breathe_underwater: false, can_pickup_items: true, can_place_blocks: true, is_affected_by_gravity: true, is_damageable: true, is_invisible: false, loses_hunger: true)
        ]
        advancements = [:]
        art = []
        attributes = []
        instruments = []
        statistics = []
        commands = [:]
        permissions = [:]
        
        recipes = [:]
        
        event_listeners = [
            "" : [].sorted(by: { $0.priority < $1.priority })
        ]
    }
    
    func player_joined() {
        let inventory_type:InventoryType = InventoryType(
            identifier: "minecraft.player_hotbar",
            categories: [],
            size: 9,
            material_category_restrictions: nil,
            material_retrictions: nil,
            recipes: nil
        )
        let inventory:Inventory = Inventory(type: inventory_type, items: [], viewers: [])
        let connection:PlayerConnection = PlayerConnection("ws://0.0.0.0:25565")
        let player:Player = Player(
            connection: connection,
            uuid: UUID(),
            name: "RandomHashTags",
            list_name: nil,
            custom_name: nil,
            display_name: nil,
            experience: 0,
            experience_level: 0,
            food_level: 20,
            permissions: [],
            statistics: [],
            game_mode: game_modes.first!.value,
            is_blocking: false,
            is_flying: false,
            is_op: true,
            is_sneaking: false,
            is_sprinting: false,
            inventory: inventory
        )
        player.location.world?.spawn_entity(player)
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
                    tick(self)
                    
                    try await Task.sleep(nanoseconds: server_tick_interval_nano)
                }
            } catch {
                print("encountered error during server loop: \(error)")
            }
        }
    }
    public func set_tick_rate(ticks_per_second: UInt8) {
        self.ticks_per_second = ticks_per_second
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        gravity_per_tick = gravity / Double(ticks_per_second)
    }
    
    public func save() {
        for (identifier, _) in worlds {
            worlds[identifier]!.save()
        }
    }
    
    public func tick(_ server: GluonServer) {
        for (identifier, _) in worlds {
            worlds[identifier]!.tick(server)
        }
    }
}

public extension GluonServer {
    static func get_nearby_entities(center: Location, x_radius: Double, y_radius: Double, z_radius: Double) -> [Entity] {
        return center.world?.entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) }) ?? []
    }
    
    static func get_entity(uuid: UUID) -> Entity? {
        for world in GluonServer.shared_instance.worlds {
            if let entity:Entity = world.entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    static func get_entities(uuids: Set<UUID>) -> [Entity] {
        return GluonServer.shared_instance.worlds.map({ $0.entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    static func get_living_entity(uuid: UUID) -> LivingEntity? {
        for world in GluonServer.shared_instance.worlds {
            if let entity:LivingEntity = world.living_entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    static func get_living_entities(uuids: Set<UUID>) -> [LivingEntity] {
        return GluonServer.shared_instance.worlds.map({ $0.living_entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    static func get_player(uuid: UUID) -> Player? {
        for world in GluonServer.shared_instance.worlds {
            if let entity:Player = world.players.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    static func get_players(uuids: Set<UUID>) -> [Player] {
        return GluonServer.shared_instance.worlds.map({ $0.players.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
}

public extension GluonServer {
    static func boot_player(player: Player, reason: String, ban_user: Bool = false, ban_user_expiration: UInt64? = nil, ban_ip: Bool = false, ban_ip_expiration: UInt64? = nil) {
        let instance:GluonServer = GluonServer.shared_instance
        player.location.world?.players.remove(player)
        player.connection.close()
        
        if ban_user {
            instance.banned_players.insert(BanEntry(target: player.uuid.uuidString, ban_time: 0, expiration: ban_user_expiration, reason: reason))
        }
        if ban_ip {
            instance.banned_ip_addresses.insert(BanEntry(target: "PLAYER_IP_ADDRESS", ban_time: 0, expiration: ban_ip_expiration, reason: reason))
        }
        // TODO: send packets
    }
}
