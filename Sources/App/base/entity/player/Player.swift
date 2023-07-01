//
//  Player.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Player : LivingEntity, CommandSender {
    var connection : PlayerConnection { get }
    
    var list_name : String? { get set }
    
    var experience : UInt64 { get set }
    var experience_level : UInt64 { get set }
    var food_level : UInt64 { get set }
    
    var permissions : Set<String> { get set }
    var statistics : [String : any StatisticActive] { get set }
    
    var game_mode : any GameMode { get set }
    var is_blocking : Bool { get set }
    var is_flying : Bool { get set }
    var is_op : Bool { get set }
    var is_sneaking : Bool { get set }
    var is_sprinting : Bool { get set }
    var last_slept_location : (any Location)? { get set }
    
    var inventory : any PlayerInventory { get set }
    
    var player_executable_context : [String : ExecutableLogicalContext] { get }
    
    mutating func tick_player(_ server: any Server)
    
    func has_permission(_ permission: String) -> Bool
    
    mutating func set_game_mode(_ game_mode: any GameMode)
    
    func kick(reason: String)
    
    func consumed(item: inout any ItemStack)
}

public extension Player {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.name.elementsEqual(rhs.name)
    }
    
    var player_executable_context : [String:ExecutableLogicalContext] {
        var context:[String:ExecutableLogicalContext] = living_entity_executable_context
        context["ping"] = ExecutableLogicalContext(value_type: .short_unsigned, value: connection.ping)
        context["game_mode"] = ExecutableLogicalContext(value_type: .string, value: game_mode.id)
        context["experience"] = ExecutableLogicalContext(value_type: .long_unsigned, value: experience)
        context["experience_level"] = ExecutableLogicalContext(value_type: .long_unsigned, value: experience_level)
        context["food_level"] = ExecutableLogicalContext(value_type: .long_unsigned, value: food_level)
        context["has_list_name"] = ExecutableLogicalContext(value_type: .boolean, value: list_name != nil)
        context["is_blocking"] = ExecutableLogicalContext(value_type: .boolean, value: is_blocking)
        context["is_flying"] = ExecutableLogicalContext(value_type: .boolean, value: is_flying)
        context["is_op"] = ExecutableLogicalContext(value_type: .boolean, value: is_op)
        context["is_sneaking"] = ExecutableLogicalContext(value_type: .boolean, value: is_sneaking)
        context["is_sprinting"] = ExecutableLogicalContext(value_type: .boolean, value: is_sprinting)
        return context
    }
    
    mutating func tick(_ server: any Server) {
        tick_player(server)
    }
    mutating func tick_player(_ server: any Server) {
        default_tick_player(server)
    }
    mutating func default_tick_player(_ server: any Server) {
        print("player " + name + " has been ticked")
        tick_living_entity(server)
    }
    
    func has_permission(_ permission: String) -> Bool {
        return permissions.contains(permission)
    }
}
