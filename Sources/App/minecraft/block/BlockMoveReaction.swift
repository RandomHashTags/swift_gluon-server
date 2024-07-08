//
//  BlockMoveReaction.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BlockMoveReaction : Identifiable {
    public let id:String
}

public extension BlockMoveReaction {
    private static func get(_ id: String) -> BlockMoveReaction {
        return BlockMoveReaction(id: id)
    }
    
    static let move = get("move")
    static let `break` = get("break")
    static let block = get("block")
    static let ignore = get("ignore")
    static let pushOnly = get("pushOnly")
}
