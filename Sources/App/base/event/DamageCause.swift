//
//  DamageCause.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public enum DamageCause {
    case contact
    case entity_attack(damager: Entity)
    case projectile(projectile: Projectile)
    case suffocation
    case fall
    case fire
    case fire_tick
    case melting
    case lava
    case drowning
    case block_explosion(block: Block)
    case entity_explosion(entity: Entity)
    case void
    case lightning
    case suicide
    case starvation
    case potion_effect(potion_effect: PotionEffect)
    case falling_block(block: Block)
    case enchantment(enchant: EnchantmentType)
    case cramming
    
    case custom(identifier: String, value: Any? = nil)
    
    var identifier : String {
        switch self {
        case .contact,
                .suffocation,
                .fall,
                .fire,
                .fire_tick,
                .melting,
                .lava,
                .drowning,
                .void,
                .lightning,
                .suicide,
                .starvation,
                .cramming:
            return String(describing: self)
        case .entity_attack(damager: _):
            return "entity_attack"
        case .projectile(projectile: _):
            return "projectile"
        case .block_explosion(block: _):
            return "block_explosion"
        case .entity_explosion(entity: _):
            return "entity_explosion"
        case .potion_effect(potion_effect: _):
            return "potion_effect"
        case .falling_block(block: _):
            return "falling_block"
        case .enchantment(enchant: _):
            return "enchantment"
            
        case .custom(identifier: let identifier, value: .some(_)):
            return identifier
        case .custom(identifier: let identifier, value: .none):
            return identifier
        }
    }
}
