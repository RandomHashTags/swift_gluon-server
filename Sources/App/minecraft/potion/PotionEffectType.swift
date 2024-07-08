//
//  PotionEffectType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs
import MinecraftMacros

public struct PotionEffectType : Identifiable, MultilingualName {
    public let id:String
    public let name:LocalizedStringResource

   //public let category:PotionEffectCategory
}

public extension PotionEffectType {
    private static func get(_ id: String) -> PotionEffectType {
        return PotionEffectType(id: "minecraft." + id, name: LocalizedStringResource.init(stringLiteral: id))
    }

    static let absorption = get("absorption")
    static let badOmen = get("badOmen")
    static let blindness = get("blindness")
    static let conduitPower = get("conduitPower")
    static let darkness = get("darkness")
    static let dolphinsGrace = get("dolphinsGrace")
    static let fireResistance = get("fireResistance")
    static let glowing = get("glowing")
    static let haste = get("haste")
    static let healthBoost = get("healthBoost")
    static let heroOfTheVillage = get("heroOfTheVillage")
    static let hunger = get("hunger")
    static let infested = get("infested")
    static let instantDamage = get("instantDamage")
    static let instantHealth = get("instantHealth")
    static let invisibility = get("invisibilty")
    static let jumpBoost = get("jumpBoost")
    static let levitation = get("levitation")
    static let luck = get("luck")
    static let miningFatigue = get("miningFatigue")
    static let nausea = get("nausea")
    static let nightVision = get("nightVision")
    static let oozing = get("oozing")
    static let poison = get("poison")
    static let raidOmen = get("raidOmen")
    static let regeneration = get("regeneration")
    static let resistance = get("resistance")
    static let saturation = get("saturation")
    static let slowFalling = get("slowFalling")
    static let slowness = get("slowness")
    static let speed = get("speed")
    static let strength = get("strength")
    static let trialOmen = get("trialOmen")
    static let unluck = get("unluck")
    static let waterBreathing = get("waterBreathing")
    static let weakness = get("weakness")
    static let weaving = get("weaving")
    static let windCharged = get("windCharged")
    static let wither = get("wither")
}