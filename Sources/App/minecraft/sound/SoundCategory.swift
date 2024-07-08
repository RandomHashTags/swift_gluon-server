//
//  SoundCategory.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct SoundCategory : Identifiable {
    public let id:String
    public let packetID:Int
}

public extension SoundCategory {
    private static func get(_ id: String, packetID: Int) -> SoundCategory {
        return SoundCategory(id: "minecraft." + id, packetID: packetID)
    }

    static let master = get("master", packetID: 0)
    static let music = get("music", packetID: 1)
    static let records = get("records", packetID: 2)
    static let weather = get("weather", packetID: 3)
    static let blocks = get("blocks", packetID: 4)
    static let hostile = get("hostile", packetID: 5)
    static let neutral = get("neutral", packetID: 6)
    static let players = get("players", packetID: 7)
    static let ambient = get("ambient", packetID: 8)
    static let voice = get("voice", packetID: 9)
}