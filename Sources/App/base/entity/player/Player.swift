//
//  Player.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class Player : LivingEntity { // TODO: make protocol
    public let connection:PlayerConnection
    
    public let name:String
    public var list_name:String?
    
    public var experience:UInt64
    public var experience_level:UInt64
    public var food_level:UInt64
    
    public var permissions:Set<String>
    public var statistics:Set<StatisticActive>
    
    public private(set) var game_mode:GameMode
    public var is_blocking:Bool
    public var is_flying:Bool
    public var is_op:Bool
    public var is_sneaking:Bool
    public var is_sprinting:Bool
    
    public var inventory:Inventory
    
    public init(
        connection: PlayerConnection,
        uuid: UUID,
        name: String,
        list_name: String?,
        custom_name: String?,
        display_name: String?,
        experience: UInt64,
        experience_level: UInt64,
        food_level: UInt64,
        permissions: Set<String>,
        statistics: Set<StatisticActive>,
        game_mode: GameMode,
        is_blocking: Bool,
        is_flying: Bool,
        is_op: Bool,
        is_sneaking: Bool,
        is_sprinting: Bool,
        inventory: Inventory
    ) {
        self.connection = connection
        self.name = name
        self.list_name = list_name
        self.experience = experience
        self.experience_level = experience_level
        self.food_level = food_level
        self.permissions = permissions
        self.statistics = statistics
        self.game_mode = game_mode
        self.is_blocking = is_blocking
        self.is_flying = is_flying
        self.is_op = is_op
        self.is_sneaking = is_sneaking
        self.is_sprinting = is_sprinting
        self.inventory = inventory
        super.init(
            uuid: uuid,
            type: GluonServer.get_entity_type(identifier: "minecraft.player")!,
            custom_name: custom_name,
            display_name: display_name,
            can_breathe_underwater: true,
            can_pickup_items: true,
            has_ai: false,
            is_climbing: false,
            is_collidable: true,
            is_gliding: false,
            is_invisible: false,
            is_leashed: false,
            is_riptiding: false,
            is_sleeping: false,
            is_swimming: false,
            potion_effects: [],
            no_damage_ticks: 0,
            no_damage_ticks_maximum: 20,
            air_remaining: 20,
            air_maximum: 20
        )
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
        try super.init(from: decoder)
    }
    
    public override func tick(_ server: GluonServer) {
        print("player " + name + " has been ticked")
        super.tick(server)
    }
    
    public func has_permission(_ permission: String) -> Bool {
        return permissions.contains(permission)
    }
    
    public func set_game_mode(_ game_mode: GameMode) {
        guard self.game_mode != game_mode else { return }
        let event:PlayerGameModeChangeEvent = PlayerGameModeChangeEvent(player: self, new_game_mode: game_mode)
        GluonServer.shared_instance.call_event(event: event)
        guard !event.is_cancelled else { return }
        self.game_mode = game_mode
    }
    
    public func kick(reason: String) {
        GluonServer.boot_player(player: self, reason: reason)
    }
    
    public func consumed(item: inout ItemStack) {
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
    
    public override var executable_context : [String:ExecutableLogicalContext] {
        var context:[String:ExecutableLogicalContext] = super.executable_context
        context["ping"] = ExecutableLogicalContext(value_type: .short_unsigned, value: connection.ping)
        context["game_mode"] = ExecutableLogicalContext(value_type: .string, value: game_mode.identifier)
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
}
