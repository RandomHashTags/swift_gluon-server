//
//  GameModeJava.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public struct GameModeJava : CaseIterable, GameMode {
    public static var allCases: [GameModeJava] = [
        GameModeJava.adventure,
        GameModeJava.creative,
        GameModeJava.spectator,
        GameModeJava.survival
    ]
    
    static var adventure:GameModeJava = {
        GameModeJava(
            id: "minecraft.adventure",
            name: "adventure",
            allows_flight: false,
            disallowed_inventory_click_types: [
                InventoryClickTypeJava.clone
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
    static var creative:GameModeJava = {
        return GameModeJava(
            id: "minecraft.creative",
            name: "creative",
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
    static var spectator:GameModeJava = {
        return GameModeJava(
            id: "minecraft.spectator",
            name: "spectator",
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
    static var survival:GameModeJava = {
        return GameModeJava(
            id: "minecraft.survival",
            name: "survival",
            allows_flight: false,
            disallowed_inventory_click_types: [
                InventoryClickTypeJava.clone
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
    public let name:LocalizedStringResource
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
