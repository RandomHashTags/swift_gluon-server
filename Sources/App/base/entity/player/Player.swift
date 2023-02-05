//
//  Player.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

public protocol Player : LivingEntity {
    var name:String { get }
    var list_name:String { get set }
    
    var experience:UInt64 { get set }
    var experience_level:UInt64 { get set }
    var food_level:UInt64 { get set }
    
    var permissions:Set<Permission> { get set }
    var statistics:Set<StatisticActive> { get set }
    
    var game_mode:GameMode { get set }
    var is_blocking:Bool { get set }
    var is_flying:Bool { get set }
    var is_op:Bool { get set }
    var is_sneaking:Bool { get set }
    var is_sprinting:Bool { get set }
    
    var inventory:Inventory { get set }
    
    func tick_player()
}
