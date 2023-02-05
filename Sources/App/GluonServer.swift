//
//  GluonServer.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public final class GluonServer {
    static var sharedInstance:GluonServer = GluonServer(ticks_per_second: 20)
    
    static func get_player_entity_type() -> EntityType {
        return sharedInstance.entity_types.first(where: { $0.identifier.elementsEqual("minecraft.player") })!
    }
    static func get_world(name: String) -> World? {
        return sharedInstance.worlds.first(where: { $0.name.elementsEqual(name) })
    }
    
    private var server_ticks_per_second:UInt8
    private var server_ticks_per_second_multiplier:Float
    private var server_tick_interval_nano:UInt64
    private var server_is_awake:Bool
    private var server_loop:Task<Void, Error>!
    private let server_gravity:Float
    private var server_gravity_per_tick:Float
    
    private var worlds:[World]
    
    private var materials:Set<Material>
    private var biomes:Set<Biome>
    private var enchantment_types:Set<EnchantmentType>
    private var entity_types:Set<EntityType>
    private var inventory_types:Set<InventoryType>
    private var potion_effect_types:Set<PotionEffectType>
    private var game_modes:Set<GameMode>
    
    private var entities:Set<Entity>
    private var living_entities:Set<LivingEntity>
    private var players:Set<Player>
    
    private init(ticks_per_second: UInt8) {
        let ticks_per_second_float:Float = Float(ticks_per_second)
        self.server_ticks_per_second = ticks_per_second
        server_ticks_per_second_multiplier = ticks_per_second_float / 20
        server_tick_interval_nano = 1_000_000_000 / UInt64(ticks_per_second)
        server_is_awake = false
        let gravity:Float = 9.8
        self.server_gravity = gravity
        server_gravity_per_tick = gravity / ticks_per_second_float
        
        worlds = []
        
        materials = []
        biomes = []
        enchantment_types = []
        entity_types = []
        inventory_types = []
        potion_effect_types = []
        game_modes = []
        
        entities = []
        living_entities = []
        players = []
    }
    
    private func wake_up() {
        guard !server_is_awake else { return }
        server_loop?.cancel()
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
