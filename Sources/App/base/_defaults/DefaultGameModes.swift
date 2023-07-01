//
//  DefaultGameModes.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public struct DefaultGameModes : CaseIterable, GameMode {
    public static var allCases: [DefaultGameModes] = [
        DefaultGameModes.adventure,
        DefaultGameModes.creative,
        DefaultGameModes.spectator,
        DefaultGameModes.survival
    ]
    
    static var adventure:DefaultGameModes = {
        DefaultGameModes(
            id: "minecraft.adventure",
            name: get_localized_string(key: "adventure", table: "GameModes"),
            allows_flight: false,
            disallowed_inventory_click_types: [
                DefaultInventoryClickType.clone
            ].map_set({ $0.id }),
            can_break_blocks: false,
            can_breathe_underwater: false,
            can_pickup_items: true,
            can_place_blocks: false,
            is_affected_by_gravity: true,
            is_damageable: true,
            is_invisible: false,
            loses_hunger: true
        )
    }()
    static var creative:DefaultGameModes = {
        return DefaultGameModes(
            id: "minecraft.creative",
            name: get_localized_string(key: "creative", table: "GameModes"),
            allows_flight: true,
            disallowed_inventory_click_types: [],
            can_break_blocks: true,
            can_breathe_underwater: true,
            can_pickup_items: true,
            can_place_blocks: true,
            is_affected_by_gravity: true,
            is_damageable: false,
            is_invisible: false,
            loses_hunger: false
        )
    }()
    static var spectator:DefaultGameModes = {
        return DefaultGameModes(
            id: "minecraft.spectator",
            name: get_localized_string(key: "spectator", table: "GameModes"),
            allows_flight: true,
            disallowed_inventory_click_types: [],
            can_break_blocks: false,
            can_breathe_underwater: true,
            can_pickup_items: false,
            can_place_blocks: false,
            is_affected_by_gravity: false,
            is_damageable: false,
            is_invisible: true,
            loses_hunger: false
        )
    }()
    static var survival:DefaultGameModes = {
        return DefaultGameModes(
            id: "minecraft.survival",
            name: get_localized_string(key: "survival", table: "GameModes"),
            allows_flight: false,
            disallowed_inventory_click_types: [
                DefaultInventoryClickType.clone
            ].map_set({ $0.id }),
            can_break_blocks: true,
            can_breathe_underwater: false,
            can_pickup_items: true,
            can_place_blocks: true,
            is_affected_by_gravity: true,
            is_damageable: true,
            is_invisible: false,
            loses_hunger: true
        )
    }()
    
    public let id:String
    public let name:String
    public let allows_flight:Bool
    public let disallowed_inventory_click_types:Set<String>
    
    public let can_break_blocks:Bool
    public let can_breathe_underwater:Bool
    public let can_pickup_items:Bool
    public let can_place_blocks:Bool
    
    public let is_affected_by_gravity:Bool
    public let is_damageable:Bool
    public let is_invisible:Bool
    
    public let loses_hunger:Bool
}
