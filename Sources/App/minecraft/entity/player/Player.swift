//
//  Player.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import Logging

public protocol Player : LivingEntity, CommandSender, Permissible {
    var list_name : String? { get set }
    
    var experience : UInt64 { get set }
    var experience_level : UInt64 { get set }
    var food_data : any FoodData { get set }
    
    var statistics : [String : any StatisticActive] { get set }
    
    var game_mode : any GameMode { get set }
    var is_blocking : Bool { get set }
    var is_flying : Bool { get set }
    var is_op : Bool { get set }
    var is_sneaking : Bool { get set }
    var is_sprinting : Bool { get set }
    var last_slept_location : (any Location)? { get set }
    
    var inventory : any PlayerInventory { get set }
        
    func tick_player(_ server: any Server)
    
    func set_game_mode(_ game_mode: any GameMode)
    
    func kick(reason: String)
    
    func consumed(item: inout any ItemStack)
}

public extension Player {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.name.elementsEqual(rhs.name)
    }
    
    func tick(_ server: any Server) {
        tick_player(server)
    }
    func tick_player(_ server: any Server) {
        default_tick_player(server)
    }
    func default_tick_player(_ server: any Server) {
        ServerMojang.instance.logger.info(Logger.Message(stringLiteral: "Player;default_tick_player;player " + name + " has been ticked"))
        tick_living_entity(server)
    }
    
    func has_permission(_ permission: String) -> Bool {
        return permissions.contains(permission)
    }
}

public extension Player {
    func server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        player_server_tps_slowed(to: tps, divisor: divisor)
    }
    internal func player_server_tps_slowed(to tps: UInt8, divisor: UInt16) {
        player_server_tps_increased(to: tps, multiplier: divisor)
    }
    
    func server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        player_server_tps_increased(to: tps, multiplier: multiplier)
    }
    internal func player_server_tps_increased(to tps: UInt8, multiplier: UInt16) {
        living_entity_server_tps_increased(to: tps, multiplier: multiplier)
    }
}
