//
//  GluonPlayer.swift
//  
//
//  Created by Evan Anderson on 4/23/23.
//

import Foundation

struct GluonPlayer : Player {
    typealias TargetStatisticActive = GluonStatisticActive
    typealias TargetGameMode = GluonGameMode
    typealias TargetPlayerInventory = GluonPlayerInventory
    typealias TargetLocation = GluonLocation
    typealias TargetPotionEffect = GluonPotionEffect
    typealias TargetItemStack = GluonItemStack
    
    let connection:PlayerConnection
    
    var name:String
    var list_name:String?
    
    var experience:UInt64
    var experience_level:UInt64
    var food_level:UInt64
    
    var permissions:Set<String>
    var statistics:[String:TargetStatisticActive]
    
    var game_mode:TargetGameMode
    
    var is_blocking:Bool
    var is_flying:Bool
    var is_op:Bool
    var is_sneaking:Bool
    var is_sprinting:Bool
    
    var inventory:TargetPlayerInventory
    
    var can_breathe_underwater:Bool
    var can_pickup_items:Bool
    var has_ai:Bool
    
    var is_climbing:Bool
    var is_collidable:Bool
    var is_gliding:Bool
    var is_invisible:Bool
    var is_leashed:Bool
    var is_riptiding:Bool
    var is_sleeping:Bool
    var is_swimming:Bool
    
    var potion_effects:[String:TargetPotionEffect]
    
    var no_damage_ticks:UInt16
    var no_damage_ticks_maximum:UInt16
    
    var air_remaining:UInt16
    var air_maximum:UInt16
    
    var health:Double
    var health_maximum:Double
    
    var uuid:UUID
    var type:EntityType
    var ticks_lived:UInt64
    var custom_name:String?
    var display_name:String?
    var boundaries:[Boundary]
    var location:TargetLocation
    var velocity:Vector
    var fall_distance:Float
    
    var is_glowing:Bool
    var is_on_fire:Bool
    var is_on_ground:Bool
    
    var height:Float
    
    var fire_ticks:UInt16
    var fire_ticks_maximum:UInt16
    
    var freeze_ticks:UInt16
    var freeze_ticks_maximum:UInt16
    
    var passenger_uuids:Set<UUID>
    var passengers : [any Entity] {
        return GluonServer.shared_instance.get_entities(uuids: passenger_uuids)
    }
    
    var vehicle_uuid:UUID?
    var vehicle : (any Entity)? {
        guard let uuid:UUID = vehicle_uuid else { return nil }
        return GluonServer.shared_instance.get_entity(uuid: uuid)
    }
    
    mutating func tick(_ server: any Server) {
        tick_player(server)
    }
    
    mutating func set_game_mode(_ game_mode: TargetGameMode) {
        guard !self.game_mode.identifier.elementsEqual(game_mode.identifier) else { return }
        let event:PlayerGameModeChangeEvent = PlayerGameModeChangeEvent(player: self, new_game_mode: game_mode)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.game_mode = game_mode
    }
    
    func kick(reason: String) {
        GluonServer.shared_instance.boot_player(player: self, reason: reason)
    }
    
    func consumed(item: inout TargetItemStack) {
        guard let consumable_configuration:MaterialItemConsumableConfiguration = item.material.configuration.item?.consumable else { return }
        let event:PlayerItemConsumeEvent = PlayerItemConsumeEvent(player: self, item: &item)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        item.amount -= 1
        guard let context:[String:ExecutableLogicalContext] = event.context else { return }
        for logic in consumable_configuration.executable_logic {
            logic.execute(context: context)
        }
    }
}
