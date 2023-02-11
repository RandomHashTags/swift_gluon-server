//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public final class GluonServer : GluonSharedInstance {
    static func get_player_entity_type() -> EntityType {
        return shared_instance.entity_types.first(where: { $0.identifier.elementsEqual("minecraft.player") })!
    }
    static func get_world(name: String) -> World? {
        return shared_instance.worlds.first(where: { $0.name.elementsEqual(name) })
    }
    static func get_advancement(identifier: String) -> Advancement? {
        return shared_instance.advancements.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_statistic(identifier: String) -> Statistic? {
        return shared_instance.statistics.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    static func get_material(identifier: String) -> Material? {
        return shared_instance.materials.first(where: { $0.identifier.elementsEqual(identifier) })
    }
    
    private var server_ticks_per_second:UInt8
    private var server_ticks_per_second_multiplier:Float
    private var server_tick_interval_nano:UInt64
    private var server_is_awake:Bool
    private var server_loop:Task<Void, Error>!
    private let server_gravity:Float
    private var server_gravity_per_tick:Float
    
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
    
    private var entities:Set<Entity>
    private var living_entities:Set<LivingEntity>
    private var players:Set<Player>
    
    convenience init() {
        self.init(ticks_per_second: 40)
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
        
        entities = []
        living_entities = []
        
        players = []
        
        for _ in 1..<10 {
            let seed:Int64 = SeedGenerator.get_random()
            print("GluonServer;init;seed=" + String(describing: seed))
        }
    }
    
    func player_joined() {
        let inventory_type:InventoryType = InventoryType(identifier: "minecraft.player_items", size: 36)
        let inventory:Inventory = Inventory(type: inventory_type, items: [], viewers: [])
        let player:Player = Player(uuid: UUID(), name: "RandomHashTags", list_name: "RandomHashTags", custom_name: nil, display_name: nil, experience: 0, experience_level: 0, food_level: 10, permissions: [], statistics: [], game_mode: game_modes.first!, is_blocking: false, is_flying: false, is_op: true, is_sneaking: false, is_sprinting: false, inventory: inventory)
        players.insert(player)
        
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
    
    func save() {
        for world in worlds {
            world.save()
        }
        for entity in entities {
            entity.save()
        }
        for living_entity in living_entities {
            living_entity.save()
        }
        for player in players {
            player.save()
        }
    }
    private func tick() {
        for entity in entities {
            entity.tick()
        }
        for living_entity in living_entities {
            living_entity.tick()
        }
        for player in players {
            player.tick()
        }
    }
}

public extension GluonServer {
    var ticks_per_second : UInt8 { server_ticks_per_second }
    var ticks_per_second_multiplier : Float { server_ticks_per_second_multiplier }
    var gravity_per_tick : Float { server_gravity_per_tick }
    
    func get_players() -> Set<Player> {
        return players
    }
}
