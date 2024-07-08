//
//  BlockFace.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BlockFace : Identifiable {
    public let id:String

    public let oppositeID:BlockFace.ID
}

public extension BlockFace {
    private static func get(_ id: BlockFace.ID, oppositeID: BlockFace.ID) -> BlockFace {
        return BlockFace(id: "minecraft." + id, oppositeID: oppositeID)
    }

    static let none = get("none", oppositeID: "none")

    static let up = get("up", oppositeID: "down")
    static let down = get("down", oppositeID: "up")

    static let north = get("north", oppositeID: "south")
    static let south = get("south", oppositeID: "north")

    static let east = get("east", oppositeID: "west")
    static let west = get("west", oppositeID: "east")
}
