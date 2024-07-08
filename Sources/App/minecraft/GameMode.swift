//
//  GameMode.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs

public struct GameMode : Identifiable, MultilingualName {
    public let id:String
    public let name:LocalizedStringResource

    /// The ``InventoryClickType`` ids not allowed for this game mode.
    let disallowedInventoryClickTypes:Set<String>

    public let allowsFlight:Bool

    public let canBreakBlocks:Bool
    public let canBreatheUnderwater:Bool
    public let canPickupItems:Bool
    public let canPlaceBlocks:Bool

    public let isAffectedByGravity:Bool
    public let isDamageable:Bool
    public let isInvisible:Bool
    
    public let losesHunger:Bool
}

public extension GameMode {
    static let adventure:GameMode = GameMode(
        id: "minecraft.adventure",
        name: "adventure",
        disallowedInventoryClickTypes: [
            InventoryClickTypeJava.clone
        ].map_set({ $0.id }),
        allowsFlight: false,
        canBreakBlocks: false,
        canBreatheUnderwater: false,
        canPickupItems: true,
        canPlaceBlocks: false,
        isAffectedByGravity: true,
        isDamageable: true,
        isInvisible: false,
        losesHunger: true
    )
    static let creative:GameMode = GameMode(
        id: "minecraft.creative",
        name: "creative",
        disallowedInventoryClickTypes: [],
        allowsFlight: true,
        canBreakBlocks: true,
        canBreatheUnderwater: true,
        canPickupItems: true,
        canPlaceBlocks: true,
        isAffectedByGravity: true,
        isDamageable: false,
        isInvisible: false,
        losesHunger: false
    )
    static let spectator:GameMode = GameMode(
        id: "minecraft.spectator",
        name: "spectator",
        disallowedInventoryClickTypes: [],
        allowsFlight: true,
        canBreakBlocks: false,
        canBreatheUnderwater: true,
        canPickupItems: false,
        canPlaceBlocks: false,
        isAffectedByGravity: false,
        isDamageable: false,
        isInvisible: true,
        losesHunger: false
    )
    static let survival:GameMode = GameMode(
        id: "minecraft.survival",
        name: "survival",
        disallowedInventoryClickTypes: [
            InventoryClickTypeJava.clone
        ].map_set({ $0.id }),
        allowsFlight: false,
        canBreakBlocks: true,
        canBreatheUnderwater: false,
        canPickupItems: true,
        canPlaceBlocks: true,
        isAffectedByGravity: true,
        isDamageable: true,
        isInvisible: false,
        losesHunger: true
    )
}