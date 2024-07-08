//
//  PlayerJava.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

final class PlayerJava : Player { // TODO: fix
    func remove() {
        
    }
    
    func teleport(_ location: any Location) {
        
    }
    
    var name:String
    var listName:String?
    
    var experience:UInt64
    var experienceLevel:UInt64
    var food_data:any FoodData
    
    var permissions:Set<String>
    var statistics:[String : any StatisticActive]
    
    var gameMode:GameMode
    
    var isBlocking:Bool
    var isFlying:Bool
    var isOP:Bool
    var isSneaking:Bool
    var isSprinting:Bool
    
    var inventory:any PlayerInventory
    
    var can_breathe_underwater:Bool
    var can_pickup_items:Bool
    var has_ai:Bool
    
    var is_climbing:Bool
    var is_collidable:Bool
    var is_gliding:Bool
    var is_invisible:Bool
    var is_leashed:Bool
    var is_riptiding:Bool
    var is_sleeping:Bool
    var is_swimming:Bool
    
    var potion_effects:[String:any PotionEffect]
    
    var no_damage_ticks:UInt16
    var no_damage_ticks_maximum:UInt16
    
    var air_remaining_ticks:UInt16
    var air_maximum_ticks:UInt16
    
    var health:Double
    var health_maximum:Double
    
    var id:UInt64
    var uuid:UUID
    var typeID:String
    var type : (EntityType)? {
        return GluonServer.shared.get_entity_type(identifier: type_id)
    }
    
    var ticks_lived:UInt64
    var customName:String?
    var displayName:String?
    var boundaries:[Boundary]
    var location:any Location
    var lastSleptLocation:(any Location)?
    var velocity:Vector
    var fallDistance:Float
    
    var is_glowing:Bool
    var is_on_fire:Bool
    var is_on_ground:Bool
    
    var height:Float
    
    var fire_ticks:UInt16
    var fire_ticks_maximum:UInt16
    
    var freeze_ticks:UInt16
    var freeze_ticks_maximum:UInt16
    
    var passenger_uuids:Set<UUID>
    var passengers : [any Entity] {
        return GluonServer.shared.get_entities(uuids: passenger_uuids)
    }
    
    var vehicle_uuid:UUID?
    var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared.get_entity(uuid: uuid)
    }
    
    func set_game_mode(_ gameMode: GameMode) {
        guard !self.gameMode.id.elementsEqual(gameMode.id) else { return }
        let event:GluonPlayerGameModeChangeEvent = GluonPlayerGameModeChangeEvent(player: self, new_game_mode: gameMode)
        GluonServer.shared.call_event(event: event)
        guard !event.isCancelled else { return }
        self.gameMode = gameMode
    }
    
    func kick(reason: String) {
        GluonServer.shared.boot_player(player: self, reason: reason)
    }
    
    func consumed(item: inout ItemStack) {
        guard let consumable_configuration:any MaterialItemConsumableConfiguration = item.material?.configuration.item?.consumable else { return }
        let event:GluonPlayerItemConsumeEvent = GluonPlayerItemConsumeEvent(player: self, item: &item)
        GluonServer.shared.call_event(event: event)
        guard !event.isCancelled else { return }
        item.amount -= 1
    }
    
    func send_packet(_ packet: any PacketMojangJava) throws {
        try ServerMojang.instance.player_connections[uuid]!.send_packet(packet)
    }
    
    func send(message: String) async {
        await GluonServer.shared.chat_manager.send(sender: self, receiver: nil, message: message)
    }
    
    init(
        name: String,
        experience: UInt64,
        experienceLevel: UInt64,
        food_data: any FoodData,
        permissions: Set<String>,
        statistics: [String:any StatisticActive],
        gameMode: GameMode,
        isBlocking: Bool,
        isFlying: Bool,
        isOP: Bool,
        isSneaking: Bool,
        isSprinting: Bool,
        inventory: any PlayerInventory,
        can_breathe_underwater: Bool,
        can_pickup_items: Bool,
        has_ai: Bool,
        is_climbing: Bool,
        is_collidable: Bool,
        is_gliding: Bool,
        is_invisible: Bool,
        is_leashed: Bool,
        is_riptiding: Bool,
        is_sleeping: Bool,
        is_swimming: Bool,
        potion_effects: [String:any PotionEffect],
        no_damage_ticks: UInt16,
        no_damage_ticks_maximum: UInt16,
        air_remaining: UInt16,
        air_maximum: UInt16,
        health: Double,
        health_maximum: Double,
        id: UInt64,
        uuid: UUID,
        type_id: String,
        ticks_lived: UInt64,
        boundaries: [Boundary],
        location: any Location,
        velocity: Vector,
        fallDistance: Float,
        is_glowing: Bool,
        is_on_fire: Bool,
        is_on_ground: Bool,
        height: Float,
        fire_ticks: UInt16,
        fire_ticks_maximum: UInt16,
        freeze_ticks: UInt16,
        freeze_ticks_maximum: UInt16,
        passenger_uuids: Set<UUID>,
        vehicle_uuid: UUID?
    ) {
        self.name = name
        self.experience = experience
        self.experienceLevel = experienceLevel
        self.food_data = food_data
        self.permissions = permissions
        self.statistics = statistics
        self.gameMode = gameMode
        self.isBlocking = isBlocking
        self.isFlying = isFlying
        self.isOP = isOP
        self.isSneaking = isSneaking
        self.isSprinting = isSprinting
        self.inventory = inventory
        self.can_breathe_underwater = can_breathe_underwater
        self.can_pickup_items = can_pickup_items
        self.has_ai = has_ai
        self.is_climbing = is_climbing
        self.is_collidable = is_collidable
        self.is_gliding = is_gliding
        self.is_invisible = is_invisible
        self.is_leashed = is_leashed
        self.is_riptiding = is_riptiding
        self.is_sleeping = is_sleeping
        self.is_swimming = is_swimming
        self.potion_effects = potion_effects
        self.no_damage_ticks = no_damage_ticks
        self.no_damage_ticks_maximum = no_damage_ticks_maximum
        self.air_remaining_ticks = air_remaining
        self.air_maximum_ticks = air_maximum
        self.health = health
        self.health_maximum = health_maximum
        self.id = id
        self.uuid = uuid
        self.type_id = type_id
        self.ticks_lived = ticks_lived
        self.boundaries = boundaries
        self.location = location
        self.velocity = velocity
        self.fallDistance = fallDistance
        self.is_glowing = is_glowing
        self.is_on_fire = is_on_fire
        self.is_on_ground = is_on_ground
        self.height = height
        self.fire_ticks = fire_ticks
        self.fire_ticks_maximum = fire_ticks_maximum
        self.freeze_ticks = freeze_ticks
        self.freeze_ticks_maximum = freeze_ticks_maximum
        self.passenger_uuids = passenger_uuids
        self.vehicle_uuid = vehicle_uuid
    }
}
