//
//  SoundCategory.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct SoundCategory : Identifiable {
    public let id:String
}

public extension SoundCategory {
    private static func get(_ id: String) -> SoundCategory {
        return SoundCategory(id: "minecraft." + id)
    }

    static let ambient = get("ambient")
    static let blocks = get("blocks")
    static let hostile = get("hostile")
    static let master = get("master")
    static let music = get("music")
    static let neutral = get("neutral")
    static let players = get("players")
    static let records = get("records")
    static let voice = get("voice")
    static let weather = get("weather")
}