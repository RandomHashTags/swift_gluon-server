//
//  PotionEffectCategory.swift
//  
//
//  Created by Evan Anderson on 7/7/24.
//

public struct PotionEffectCategory : Identifiable {
    public let id:String
}

public extension PotionEffectCategory {
    private static func get(_ id: String) -> PotionEffectCategory {
        return PotionEffectCategory(id: id)
    }
    static let beneficial = get("beneficial")
    static let harmful = get("harmful")
    static let neutral = get("neutral")
}