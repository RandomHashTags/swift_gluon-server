//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol Event {
    var type : any EventType { get }
    var context : [String : ExecutableLogicalContext]? { get }
}

public extension Event {
    func parse_server_context(key: String) -> ExecutableLogicalContext? {
        switch key {
        case "server_gravity":
            return ExecutableLogicalContext(value_type: .double, value: GluonServer.shared.gravity)
        case "server_gravity_per_tick":
            return ExecutableLogicalContext(value_type: .double, value: GluonServer.shared.gravity_per_tick)
        case "server_max_players":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: GluonServer.shared.max_players)
        case "server_ticks_per_second":
            return ExecutableLogicalContext(value_type: .char_unsigned, value: GluonServer.shared.ticks_per_second)
        case "server_ticks_per_second_multiplier":
            return ExecutableLogicalContext(value_type: .double, value: GluonServer.shared.ticks_per_second_multiplier)
        default:
            return nil
        }
    }
    
    func parse_entity_context(key: String, entity: any Entity) -> ExecutableLogicalContext? {
        switch key {
        case "entity_type":
            return ExecutableLogicalContext(value_type: .string, value: entity.type_id)
            
        case "is_on_fire":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.is_on_fire)
        case "is_on_ground":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.is_on_ground)
            
        case "ticks_lived":
            return ExecutableLogicalContext(value_type: .long_unsigned, value: entity.ticks_lived)
        default:
            return parse_server_context(key: key)
        }
    }
    
    func parse_literal_damageable_context(key: String, damageable: any Damageable) -> ExecutableLogicalContext? {
        switch key {
        case "health":
            return ExecutableLogicalContext(value_type: .double, value: damageable.health)
        case "health_maximum":
            return ExecutableLogicalContext(value_type: .double, value: damageable.health_maximum)
            
        default:
            return parse_entity_context(key: key, entity: damageable)
        }
    }
    private func parse_function_damageable_context(key: String, damageable: any Damageable) -> ExecutableLogicalContext? {
        let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
        switch values[0] {
        default:
            return nil
        }
    }
    func parse_damageable_context(key: String, damageable: any Damageable) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            return parse_function_damageable_context(key: key, damageable: damageable)
        } else {
            return parse_literal_damageable_context(key: key, damageable: damageable)
        }
    }
    
    private func parse_function_living_entity_context(key: String, entity: some LivingEntity) -> ExecutableLogicalContext? {
        let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
        switch values[0] {
        case "has_potion_effect":
            return ExecutableLogicalContext(value_type: .boolean, value: entity.potion_effects.values.first(where: { $0.type_id.elementsEqual(value) }))
        default:
            return parse_function_damageable_context(key: key, damageable: entity)
        }
    }
    func parse_living_entity_context(key: String, entity: any LivingEntity) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            return parse_function_living_entity_context(key: key, entity: entity)
        } else {
            return nil
        }
    }
    
    func parse_player_context(key: String, player: any Player) -> ExecutableLogicalContext? {
        if key.contains("(") && key.contains(")") {
            let values:[Substring] = key.split(separator: "("), value:String = String(values[1].split(separator: ")")[0])
            switch values[0] {
            case "has_permission":
                return ExecutableLogicalContext(value_type: .boolean, value: player.permissions.contains(value))
            default:
                return parse_function_living_entity_context(key: key, entity: player)
            }
        } else {
            return nil
        }
    }
}
