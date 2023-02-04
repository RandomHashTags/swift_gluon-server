//
//  Player.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

public class Player : LivingEntity {
    public let name:String
    public var list_name:String
    
    public var experience:UInt64, experience_level:UInt64, food_level:UInt64
    
    public var permissions:Set<UnsafePointer<Permission>>
    public var statistics:Set<StatisticActive>
    
    public var game_mode:UnsafePointer<GameMode>
    public var is_blocking:Bool
    public var is_flying:Bool
    public var is_op:Bool
    public var is_sneaking:Bool
    public var is_sprinting:Bool
    
    var inventory:Inventory
    
    public init(
        uuid: UInt64,
        type: UnsafePointer<EntityType>,
        name: String,
        list_name: String,
        display_name: String?,
        location: Location,
        experience: UInt64,
        experience_level: UInt64,
        food_level: UInt64,
        permissions: Set<UnsafePointer<Permission>>,
        statistics: Set<StatisticActive>,
        game_mode: UnsafePointer<GameMode>,
        is_blocking: Bool,
        is_flying: Bool,
        is_op: Bool,
        is_sneaking: Bool,
        is_sprinting: Bool,
        inventory: Inventory,
        
        potion_effects: Set<PotionEffect>?,
        no_damage_ticks: UInt16,
        no_damage_ticks_maximum: UInt16,
        air_remaining: UInt16,
        air_maximum: UInt16
    ) {
        self.name = name
        self.list_name = list_name
        self.experience = experience
        self.experience_level = experience_level
        self.food_level = food_level
        self.permissions = permissions
        self.statistics = statistics
        self.game_mode = game_mode
        self.is_blocking = is_blocking
        self.is_flying = is_flying
        self.is_op = is_op
        self.is_sneaking = is_sneaking
        self.is_sprinting = is_sprinting
        self.inventory = inventory
        super.init(uuid: uuid, type: type, display_name: display_name, location: location, can_breathe_underwater: true, can_pickup_items: true, has_ai: true, is_climbing: false, is_collidable: true, is_gliding: false, is_invisible: false, is_leashed: false, is_riptiding: false, is_sleeping: false, is_swimming: false, potion_effects: potion_effects, no_damage_ticks: no_damage_ticks, no_damage_ticks_maximum: no_damage_ticks_maximum, air_remaining: air_remaining, air_maximum: air_maximum)
    }
    
    public override func tick() {
        // TODO: Player tick logic
        super.tick()
    }
}
