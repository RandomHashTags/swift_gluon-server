//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import HugeNumbers

final class GluonServer : GluonSharedInstance, Server {
    var chat_manager:any ChatManager
    var version:SemanticVersion
    
    var ticks_per_second:UInt8
    var ticks_per_second_multiplier:HugeFloat
    var server_tick_interval_nano:UInt64
    var server_is_awake:Bool
    var server_loop:Task<Void, Error>!
    var gravity:HugeFloat
    var gravity_per_tick:HugeFloat
    var void_damage_per_tick:Double
    var fire_damage_per_second:Double
    
    var max_players:UInt64
    var port:Int
    var has_whitelist:Bool
    var whitelisted_players:Set<UUID>
    var banned_players:Set<BanEntry>
    var banned_ip_addresses:Set<BanEntry>
    
    var difficulties:[String : any Difficulty]
    var worlds:[String : any World]
    
    var event_types:[String : any EventType]
    
    var sound_categories:[String : any SoundCategory]
    var sounds:[String : any Sound]
    var materials:[String : any Material]
    var biomes:[String : any Biome]
    var enchantment_types:[String : any EnchantmentType]
    var entity_types:[String : any EntityType]
    var inventory_types:[String : any InventoryType]
    var potion_effect_types:[String : any PotionEffectType]
    var game_modes:[String : any GameMode]
    var advancements:[String : any Advancement]
    var art:[String : any Art]
    var attributes:[String : any Attribute]
    var instruments:[String : any Instrument]
    var statistics:[String : any Statistic]
    var commands:[String : any Command]
    var permissions:[String : any Permission]
    var recipes:[String : any Recipe]
    
    var event_listeners:[String:[any EventListener]]
    
    convenience init() {
        self.init(ticks_per_second: 1)
    }
    private init(ticks_per_second: UInt8) {
        chat_manager = GluonChatManager()
        version = SemanticVersion(major: 1, minor: 20, patch: 1)
        
        let ticks_per_second_float:HugeFloat = HugeFloat(ticks_per_second)
        self.ticks_per_second = ticks_per_second
        ticks_per_second_multiplier = ticks_per_second_float / 20
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_is_awake = false
        let gravity:HugeFloat = HugeFloat("9.80665")
        self.gravity = gravity
        gravity_per_tick = gravity / ticks_per_second_float
        void_damage_per_tick = 1 / Double(ticks_per_second_float.represented_float)
        fire_damage_per_second = 1
        
        print("server_ticks_per_second=\(ticks_per_second); 1 every \(1000 / Int(ticks_per_second)) milliseconds")
        
        max_players = 1
        port = 25565
        has_whitelist = false
        whitelisted_players = []
        banned_players = []
        banned_ip_addresses = []
        
        difficulties = [
            "minecraft.easy" : GluonDifficulty(id: "minecraft.easy", name: "Easy", damage_multiplier: 0.5),
            "minecraft.normal" : GluonDifficulty(id: "minecraft.normal", name: "Normal", damage_multiplier: 1),
            "minecraft.hard" : GluonDifficulty(id: "minecraft.hard", name: "Hard", damage_multiplier: 1.5),
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
        
        sound_categories = [:]
        sounds = [:]
        materials = [:]
        biomes = [:]
        enchantment_types = [:]
        entity_types = [
            "minecraft.player" : GluonEntityType(id: "minecraft.player", name: "Player", is_affected_by_gravity: true, is_damageable: true, receives_fall_damage: true, no_damage_ticks_maximum: 20, fire_ticks_maximum: 20, freeze_ticks_maximum: 20)
        ]
        inventory_types = [:]
        potion_effect_types = [:]
        
        game_modes = [:]
        for game_mode in DefaultGameModes.allCases {
            game_modes[game_mode.id] = game_mode
        }
        advancements = [:]
        art = [:]
        attributes = [:]
        instruments = [:]
        statistics = [:]
        
        commands = [:]
        for command in DefaultCommands.allCases {
            commands[command.id] = command
        }
        
        permissions = [:]
        for permission in DefaultPermissions.allCases {
            permissions[permission.id] = permission
        }
        
        recipes = [:]
        
        event_listeners = [
            "" : [].sorted(by: { $0.priority < $1.priority })
        ]
    }
    
    func player_joined() {
        let inventory_type:GluonInventoryType = GluonInventoryType(
            id: "minecraft.player_hotbar",
            categories: [],
            size: 9,
            material_category_restrictions: nil,
            material_retrictions: nil,
            allowed_recipe_ids: nil
        )
        let inventory:GluonPlayerInventory = GluonPlayerInventory(type: inventory_type, held_item_slot: 0, items: [], viewers: [])
        let connection:PlayerConnection = PlayerConnection("ws://0.0.0.0:25565")
        let player:GluonPlayer = GluonPlayer(
            connection: connection,
            name: "RandomHashTags",
            experience: 0,
            experience_level: 0,
            food_level: 20,
            permissions: [],
            statistics: [:],
            game_mode: DefaultGameModes.survival,
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
            type_id: "minecraft.player",
            ticks_lived: 0,
            boundaries: [],
            location: GluonLocation(world: worlds.first!.value, x: HugeFloat.zero, y: HugeFloat.zero, z: HugeFloat.zero, yaw: 0, pitch: 0),
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
    
    /*func save() {
        for (identifier, _) in worlds {
            worlds[identifier]!.save()
        }
    }*/
    
    func tick(_ server: any Server) {
        for (identifier, _) in worlds {
            worlds[identifier]!.tick(server)
        }
    }
}

extension GluonServer {
    func get_nearby_entities(center: any Location, x_radius: HugeFloat, y_radius: HugeFloat, z_radius: HugeFloat) -> [any Entity] {
        return center.world.entities.filter({ $0.location.is_nearby(center: center, x_radius: x_radius, y_radius: y_radius, z_radius: z_radius) })
    }
    
    func get_entity(uuid: UUID) -> (any Entity)? {
        for (_, world) in worlds {
            if let entity:any Entity = world.entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_entities(uuids: Set<UUID>) -> [any Entity] {
        return worlds.values.map({ $0.entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    func get_living_entity(uuid: UUID) -> (any LivingEntity)? {
        for (_, world) in worlds {
            if let entity:any LivingEntity = world.living_entities.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_living_entities(uuids: Set<UUID>) -> [any LivingEntity] {
        return worlds.values.map({ $0.living_entities.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
    
    func get_player(uuid: UUID) -> (any Player)? {
        for (_, world) in worlds {
            if let entity:any Player = world.players.first(where: { $0.uuid == uuid }) {
                return entity
            }
        }
        return nil
    }
    func get_players(uuids: Set<UUID>) -> [any Player] {
        return worlds.values.map({ $0.players.filter({ uuids.contains($0.uuid) }) }).flatMap({ $0 })
    }
}

extension GluonServer {
    func boot_player(player: any Player, reason: String, ban_user: Bool = false, ban_user_expiration: UInt64? = nil, ban_ip: Bool = false, ban_ip_expiration: UInt64? = nil) {
        let location:any Location = player.location, world:any World = location.world
        let player_uuid:UUID = player.uuid
        guard let index:Int = world.players.firstIndex(where: { $0.uuid == player_uuid }) else { return }
        world.players.remove(at: index)
        player.connection.close()
        
        let instance:GluonServer = GluonServer.shared_instance
        if ban_user {
            instance.banned_players.insert(BanEntry(banned_by: UUID(), target: player.uuid.uuidString, ban_time: 0, expiration: ban_user_expiration, reason: reason))
        }
        if ban_ip {
            instance.banned_ip_addresses.insert(BanEntry(banned_by: UUID(), target: "PLAYER_IP_ADDRESS", ban_time: 0, expiration: ban_ip_expiration, reason: reason))
        }
        // TODO: send packets
    }
}
