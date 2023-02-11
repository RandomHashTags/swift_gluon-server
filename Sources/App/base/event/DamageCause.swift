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
}
