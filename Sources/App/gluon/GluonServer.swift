//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import huge_numbers

final class GluonServer : GluonSharedInstance, Server {
    typealias TargetWorld = GluonWorld
    typealias TargetEventType = GluonEventType
    typealias TargetLocation = GluonLocation
    typealias TargetEntity = GluonEntity
    typealias TargetLivingEntity = GluonLivingEntity
    typealias TargetPlayer = GluonPlayer
    typealias TargetMaterial = GluonMaterial
    typealias TargetInventoryType = GluonInventoryType
    typealias TargetGameMode = GluonGameMode
    typealias TargetStatistic = GluonStatistic
    typealias TargetRecipe = GluonRecipe
    
    var ticks_per_second:UInt8
    var ticks_per_second_multiplier:HugeFloat
    var server_tick_interval_nano:UInt64
    var server_is_awake:Bool
    var server_loop:Task<Void, Error>!
    var gravity:HugeFloat
    var gravity_per_tick:HugeFloat
    var void_damage_per_tick:Double
    
    var max_players:UInt64
    var port:Int
    var has_whitelist:Bool
    var whitelisted_players:Set<UUID>
    var banned_players:Set<BanEntry>
    var banned_ip_addresses:Set<BanEntry>
    
    var difficulties:[String:Difficulty]
    var worlds:[String:TargetWorld]
    
    var event_types:[String:TargetEventType]
    
    var sound_categories:Set<SoundCategory>
    var sounds:Set<Sound>
    var materials:[String:TargetMaterial]
    var biomes:Set<Biome>
    var enchantment_types:[String:EnchantmentType]
    var entity_types:[String:EntityType]
    var inventory_types:[String:TargetInventoryType]
    var potion_effect_types:[String:PotionEffectType]
    var game_modes:[String:TargetGameMode]
    var advancements:[String:Advancement]
    var art:Set<Art>
    var attributes:Set<Attribute>
    var instruments:Set<Instrument>
    var statistics:[String:TargetStatistic]
    var commands:[String:Command]
    var permissions:[String:Permission]
    var recipes:[String:TargetRecipe]
    
    var event_listeners:[String:[any EventListener]]
    
    convenience init() {
        self.init(ticks_per_second: 1)
    }
    private init(ticks_per_second: UInt8) {
        let ticks_per_second_float:HugeFloat = HugeFloat(ticks_per_second)
        self.ticks_per_second = ticks_per_second
        ticks_per_second_multiplier = ticks_per_second_float / 20
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_is_awake = false
        let gravity:HugeFloat = HugeFloat("9.80665")
        self.gravity = gravity
        gravity_per_tick = gravity / ticks_per_second_float
        void_damage_per_tick = 1 / Double(ticks_per_second_float.represented_float)
        
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
                y_min: HugeFloat("-64"),
                y_max: HugeFloat("320"),
                y_sea_level: HugeFloat("100"),
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
        
        event_types = [:]
        
        sound_categories = []
        sounds = []
        materials = [:]
        biomes = []
        enchantment_types = [:]
        entity_types = [
            "minecraft.player" : EntityType(identifier: "minecraft.player", name: MultilingualStrings(english: "Player"), is_affected_by_gravity: true, is_damageable: true, receives_fall_damage: true, no_damage_ticks_maximum: 20, fire_ticks_maximum: 20, freeze_ticks_maximum: 20)
        ]
        inventory_types = [:]
        potion_effect_types = [:]
        
        let survival_game_mode:GluonGameMode = GluonGameMode(identifier: "minecraft.survival", name: MultilingualStrings(english: "Survival"), allows_flight: false, can_break_blocks: true, can_breathe_underwater: false, can_pickup_items: true, can_place_blocks: true, is_affected_by_gravity: true, is_damageable: true, is_invisible: false, loses_hunger: true)
        game_modes = [
            "minecraft.survival" : survival_game_mode
        ]
        advancements = [:]
        art = []
        attributes = []
        instruments = []
        statistics = [:]
        commands = [:]
        permissions = [:]
        
        recipes = [:]
        
        event_listeners = [
            "" : [].sorted(by: { $0.priority < $1.priority })
        ]
    }
    
    func player_joined() {
        let inventory_type:GluonInventoryType = GluonInventoryType(
            identifier: "minecraft.player_hotbar",
            categories: [],
            size: 9,
            material_category_restrictions: nil,
            material_retrictions: nil,
            allowed_recipe_identifiers: nil
        )
        let inventory:GluonPlayerInventory = GluonPlayerInventory(type: inventory_type, items: [], viewers: [])
        let connection:PlayerConnection = PlayerConnection("ws://0.0.0.0:25565")
        let player:GluonPlayer = GluonPlayer(
            connection: connection,
            name: "RandomHashTags",
            experience: 0,
            experience_level: 0,
            food_level: 20,
            permissions: [],
            statistics: [:],
            game_mode: game_modes.first!.value,
            is_blocking: false,
            is_flying: false,
            is_op: false,
            is_sneaking: false,
            is_sprinting: false,
            inventory: inventory,
            can_breathe_underwater: false,
            can_pickup_items: true,
            has_ai: false,
            is_climbing: false,
            is_collidable: true,
            is_gliding: false,
            is_invisible: false,
            is_leashed: false,
            is_riptiding: false,
            is_sleeping: false,
            is_swimming: false,
            potion_effects: [:],
            no_damage_ticks: 0,
            no_damage_ticks_maximum: 20,
            air_remaining: 20,
            air_maximum: 20,
            health: 20,
            health_maximum: 20,
            uuid: UUID(),
            type: entity_types["minecraft.player"]!,
            ticks_lived: 0,
            boundaries: [],
            location: TargetLocation(world: worlds.first!.value, x: HugeFloat.zero, y: HugeFloat.zero, z: HugeFloat.zero, yaw: 0, pitch: 0),
            velocity: Vector(x: 0, y: 0, z: 0),
            fall_distance: 0,
            is_glowing: false,
            is_on_fire: false,
            is_on_ground: false,
            height: 5,
            fire_ticks: 0,
            fire_ticks_maximum: 20,
            freeze_ticks: 0,
            freeze_ticks_maximum: 20,
            passenger_uuids: [],
            vehicle_uuid: nil
        )
        worlds["overworld"]!.spawn_player(player)
        call_event(event: GluonPlayerJoinEvent(player))
        
        if !server_is_awake {
            wake_up()
        }
    }
    
    func wake_up() {
        guard !server_is_awake else { return }
        server_is_awake = true
        server_loop = Task {
            while server_is_awake {
                tick(self)
                try! await Task.sleep(nanoseconds: server_tick_interval_nano)
            }
        }
    }
    func set_tick_rate(ticks_per_second: UInt8) {
        self.ticks_per_second = ticks_per_second
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        gravity_per_tick = gravity / Double(ticks_per_second)
    }
    
    func save() {
        for (identifier, _) in worlds {
            worlds[identifier]!.save()
        }
    }
    
    func tick(_ server: any Server) {
        for (identifier, _) in worlds {
            worlds[identifier]!.tick(server)
        }
    }
}

extension GluonServer {
    func get_nearby_entities(center: TargetLocation, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [TargetEntity] {
        return center.world.entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    func get_entity(uuid: UUID) -> TargetEntity? {
        for (_, world) in worlds {
            if let entity:TargetEntity = world.entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_entities(uuids: Set<UUID>) -> [TargetEntity] {
        return worlds.values.map({ $0.entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    func get_living_entity(uuid: UUID) -> TargetLivingEntity? {
        for (_, world) in worlds {
            if let entity:TargetLivingEntity = world.living_entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_living_entities(uuids: Set<UUID>) -> [TargetLivingEntity] {
        return worlds.values.map({ $0.living_entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    func get_player(uuid: UUID) -> TargetPlayer? {
        for (_, world) in worlds {
            if let entity:TargetPlayer = world.players.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_players(uuids: Set<UUID>) -> [TargetPlayer] {
        return worlds.values.map({ $0.players.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
}

extension GluonServer {
    func boot_player(player: TargetPlayer, reason: String, ban_user: Bool = false, ban_user_expiration: UInt64? = nil, ban_ip: Bool = false, ban_ip_expiration: UInt64? = nil) {
        let location:TargetLocation = player.location, world:TargetWorld = location.world
        guard let index:Int = world.players.firstIndex(of: player) else { return }
        world.players.remove(at: index)
        player.connection.close()
        
        let instance:GluonServer = GluonServer.shared_instance
        if ban_user {
            instance.banned_players.insert(BanEntry(target: player.uuid.uuidString, ban_time: 0, expiration: ban_user_expiration, reason: reason))
        }
        if ban_ip {
            instance.banned_ip_addresses.insert(BanEntry(target: "PLAYER_IP_ADDRESS", ban_time: 0, expiration: ban_ip_expiration, reason: reason))
        }
        // TODO: send packets
    }
}
