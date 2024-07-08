//
//  EnchantmentType..swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation
import SwiftStringCatalogs

public struct EnchantmentType : Identifiable, MultilingualName {
    public let id:String
    public let name:LocalizedStringResource

    //public let weight:UInt16
    public let maxLevel:UInt16

    /// the ``EnchantmentType`` ids this enchantment type conflicts with.
    //public let conflictsWith:Set<String>

    //public let isTreasure:Bool
    //public let isCursed:Bool
}

public extension EnchantmentType {
    private static func get(_ id: String, maxLevel: UInt16) -> EnchantmentType {
        return EnchantmentType(id: "minecraft." + id, name: LocalizedStringResource(stringLiteral: id), maxLevel: maxLevel)
    }

    static let aquaAffinity = get("aquaAffinity", maxLevel: 1)
    static let baneOfArthropods = get("baneOfArthropods", maxLevel: 5)
    static let bindingCurse = get("bindingCurse", maxLevel: 1)
    static let blastProtection = get("blastProtection", maxLevel: 4)
    static let breach = get("breach", maxLevel: 4)
    static let channeling = get("channeling", maxLevel: 1)
    static let density = get("density", maxLevel: 5)
    static let depthStrider = get("depthStrider", maxLevel: 3)
    static let efficiency = get("efficiency", maxLevel: 5)
    static let featherFalling = get("featherFalling", maxLevel: 4)
    static let fireAspect = get("fireAspect", maxLevel: 2)
    static let fireProtection = get("fireProtection", maxLevel: 4)
    static let flame = get("flame", maxLevel: 1)
    static let fortune = get("fortune", maxLevel: 3)
    static let frostWalker = get("frostWalker", maxLevel: 2)
    static let impaling = get("impaling", maxLevel: 5)
    static let infinity = get("infinity", maxLevel: 1)
    static let knockback = get("knockback", maxLevel: 2)
    static let looting = get("looting", maxLevel: 3)
    static let loyalty = get("loyalty", maxLevel: 3)
    static let luckOfTheSea = get("luckOfTheSea", maxLevel: 3)
    static let lure = get("lure", maxLevel: 3)
    static let mending = get("mending", maxLevel: 1)
    static let multishot = get("multishot", maxLevel: 3)
    static let piercing = get("piercing", maxLevel: 5)
    static let power = get("power", maxLevel: 5)
    static let projectileProtection = get("projectileProtection", maxLevel: 4)
    static let protection = get("protection", maxLevel: 4)
    static let punch = get("punch", maxLevel: 2)
    static let quickCharge = get("quickCharge", maxLevel: 3)
    static let respiration = get("respiration", maxLevel: 3)
    static let riptide = get("riptide", maxLevel: 3)
    static let sharpness = get("sharpness", maxLevel: 5)
    static let silkTouch = get("silkTouch", maxLevel: 1)
    static let smite = get("smite", maxLevel: 5)
    static let soulSpeed = get("soulSpeed", maxLevel: 3)
    static let sweepingEdge = get("sweepingEdge", maxLevel: 3)
    static let swiftSneak = get("swiftSneak", maxLevel: 3)
    static let thorns = get("thorns", maxLevel: 4)
    static let unbreaking = get("unbreaking", maxLevel: 3)
    static let vanishingCurse = get("vanishingCurse", maxLevel: 1)
    static let windBurst = get("windBurst", maxLevel: 3)
}