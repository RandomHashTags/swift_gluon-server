//
//  LivingEntity.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class LivingEntity : Damageable {
    public var can_breathe_underwater:Bool
    public var can_pickup_items:Bool
    public var has_ai:Bool
    
    public var is_climbing:Bool
    public var is_collidable:Bool
    public var is_gliding:Bool
    public var is_invisible:Bool
    public var is_leashed:Bool
    public var is_riptiding:Bool
    public var is_sleeping:Bool
    public var is_swimming:Bool
    
    public var potion_effects:Set<PotionEffect>
    
    public var no_damage_ticks:UInt16
    public var no_damage_ticks_maximum:UInt16
    
    public var air_remaining:UInt16
    public var air_maximum:UInt16
    
    public init(
        uuid: UUID,
        type: EntityType,
        custom_name: String?,
        display_name: String?,
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
        potion_effects: Set<PotionEffect>,
        no_damage_ticks: UInt16,
        no_damage_ticks_maximum: UInt16,
        air_remaining: UInt16,
        air_maximum: UInt16
    ) {
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
        self.air_remaining = air_remaining
        self.air_maximum = air_maximum
        super.init(
            uuid: uuid,
            type: type,
            custom_name: custom_name,
            display_name: display_name,
            health: 20,
            health_maximum: 20
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    public override func tick(_ server: GluonServer) {
        print("living entity with uuid " + uuid.uuidString + " has been ticked")
        if no_damage_ticks > 0 {
            no_damage_ticks -= 1
        }
        
        var removed_potion_effects:Set<PotionEffect> = Set<PotionEffect>()
        for potion_effect in potion_effects {
            let new_duration:UInt16 = potion_effect.duration - 1
            if new_duration == 0 {
                removed_potion_effects.insert(potion_effect)
            } else {
                potion_effect.duration = new_duration
            }
        }
        potion_effects.remove(contentsOf: removed_potion_effects)
        
        super.tick(server)
    }
    
    public override func damage(cause: DamageCause, amount: Double) -> DamageResult {
        let result:DamageResult = super.damage(cause: cause, amount: amount)
        if no_damage_ticks == 0 {
            no_damage_ticks = no_damage_ticks_maximum
        }
        return result
    }
}
