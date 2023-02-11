//
//  BlockMoveReaction.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public enum BlockMoveReaction : String, Jsonable {
    case move
    case `break`
    case block
    case ignore
    case push_only
}
