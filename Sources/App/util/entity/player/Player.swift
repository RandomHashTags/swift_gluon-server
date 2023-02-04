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
    
    public var game_mode:UnsafeMutablePointer<GameMode>
    public var is_blocking:Bool
    public var is_flying:Bool
    public var is_op:Bool
    public var is_sneaking:Bool
    public var is_sprinting:Bool
    
    public init(type: UnsafePointer<EntityType>,
                name: String,
                list_name: String,
                experience: UInt64,
                experience_level: UInt64,
                food_level: UInt64,
                permissions: Set<UnsafePointer<Permission>>,
                game_mode: UnsafeMutablePointer<GameMode>,
                is_blocking: Bool,
                is_flying: Bool,
                is_op: Bool,
                is_sneaking: Bool,
                is_sprinting: Bool
    ) {
        self.name = name
        self.list_name = list_name
        self.experience = experience
        self.experience_level = experience_level
        self.food_level = food_level
        self.permissions = permissions
        self.game_mode = game_mode
        self.is_blocking = is_blocking
        self.is_flying = is_flying
        self.is_op = is_op
        self.is_sneaking = is_sneaking
        self.is_sprinting = is_sprinting
        super.init(uuid: 0, type: type, can_breathe_underwater: true, can_pickup_items: true, has_ai: true, is_climbing: false, is_collidable: true, is_gliding: false, is_invisible: false, is_leashed: false, is_riptiding: false, is_sleeping: false, is_swimming: false)
    }
    
    public override func tick() {
        // TODO: Player tick logic
        super.tick()
    }
}
