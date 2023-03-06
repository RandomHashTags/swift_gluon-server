//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol Event {
    var type:EventType { get }
    func get_context(key: String) -> ExecutableLogicalContext?
}

public extension Event {
    func parse_entity_context(key: String, entity: Entity) -> ExecutableLogicalContext? {
        switch key {
        case "entity_type":
            return ExecutableLogicalContext(value_type: .string, value: entity.type.identifier)
            
        case "is_on_fire":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.is_on_fire)
        case "is_on_ground":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.is_on_ground)
            
        case "ticks_lived":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: entity.ticks_lived)
        default:
            return nil
        }
    }
    
    func parse_literal_damageable_context(key: String, damageable: Damageable) -> ExecutableLogicalContext? {
        switch key {
        case "health":
            return ExecutableLogicalContext(value_type: .double, value: damageable.health)
        case "health_maximum":
            return ExecutableLogicalContext(value_type: .double, value: damageable.health_maximum)
            
        default:
            return parse_entity_context(key: key, entity: damageable)
        }
    }
    private func parse_function_damageable_context(key: String, damageable: Damageable) -> ExecutableLogicalContext? {
        let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
        switch values[0] {
        default:
            return nil
        }
    }
    func parse_damageable_context(key: String, damageable: Damageable) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            return parse_function_damageable_context(key: key, damageable: damageable)
        } else {
            return parse_literal_damageable_context(key: key, damageable: damageable)
        }
    }
    
    func parse_literal_living_entity_context(key: String, entity: LivingEntity) -> ExecutableLogicalContext? {
        switch key {
            
        case "air_remaining":
            return ExecutableLogicalContext(value_type: .short_unsigned, value: entity.air_remaining)
        case "air_maximum":
            return ExecutableLogicalContext(value_type: .short_unsigned, value: entity.air_maximum)
            
        case "is_swimming":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.is_swimming)
            
        case "no_damage_ticks":
            return ExecutableLogicalContext(value_type: .short_unsigned, value: entity.no_damage_ticks)
        case "no_damage_ticks_maximum":
            return ExecutableLogicalContext(value_type: .short_unsigned, value: entity.no_damage_ticks_maximum)
            
        default:
            return parse_damageable_context(key: key, damageable: entity)
        }
    }
    private func parse_function_living_entity_context(key: String, entity: LivingEntity) -> ExecutableLogicalContext? {
        let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
        switch values[0] {
        case "has_potion_effect":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.potion_effects.first(where: { $0.type_identifier.elementsEqual(value) }))
        default:
            return parse_function_damageable_context(key: key, damageable: entity)
        }
    }
    func parse_living_entity_context(key: String, entity: LivingEntity) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            return parse_function_living_entity_context(key: key, entity: entity)
        } else {
            return parse_literal_living_entity_context(key: key, entity: entity)
        }
    }
    
    private func parse_literal_player_context(key: String, player: Player) -> ExecutableLogicalContext? {
        switch key {
        case "ping":
            return ExecutableLogicalContext(value_type: .short_unsigned, value: player.connection.ping)
            
        case "game_mode":
            return ExecutableLogicalContext(value_type: .string, value: player.game_mode.identifier)
        case "experience":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: player.experience)
        case "experience_level":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: player.experience_level)
            
        case "food_level":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: player.food_level)
            
        case "has_list_name":
            return ExecutableLogicalContext(value_type: .boolean, value: player.list_name != nil)
            
        case "is_blocking":
            return ExecutableLogicalContext(value_type: .boolean, value: player.is_blocking)
        case "is_flying":
            return ExecutableLogicalContext(value_type: .boolean, value: player.is_flying)
        case "is_op":
            return ExecutableLogicalContext(value_type: .boolean, value: player.is_op)
        case "is_sneaking":
            return ExecutableLogicalContext(value_type: .boolean, value: player.is_sneaking)
        case "is_sprinting":
            return ExecutableLogicalContext(value_type: .boolean, value: player.is_sprinting)
            
        default:
            return parse_living_entity_context(key: key, entity: player)
        }
    }
    func parse_player_context(key: String, player: Player) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
            switch values[0] {
            case "has_permission":
                return ExecutableLogicalContext(value_type: .boolean, value: player.permissions.contains(value))
            default:
                return parse_function_living_entity_context(key: key, entity: player)
            }
        } else {
            return parse_literal_player_context(key: key, player: player)
        }
    }
}
