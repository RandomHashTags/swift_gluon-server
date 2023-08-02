//
//  CPMChangeDifficulty.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang {
    /// Changes the difficulty setting in the client's option menu.
    struct ChangeDifficulty : ClientPacketMojangProtocol {
        let difficulty:ChangeDifficulty.Difficulty
        let difficulty_locked:Bool
        
        enum Difficulty : UInt8, Hashable, Codable {
            case peaceful = 0
            case easy
            case normal
            case hard
        }
    }
}
