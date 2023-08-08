//
//  CPMPChangeDifficulty.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Changes the difficulty setting in the client's option menu.
    struct ChangeDifficulty : ClientPacketMojangPlayProtocol {
        public let difficulty:ChangeDifficulty.Difficulty
        public let difficulty_locked:Bool
        
        public enum Difficulty : UInt8, Hashable, Codable, PacketEncodableMojang {
            case peaceful = 0
            case easy
            case normal
            case hard
        }
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [difficulty, difficulty_locked]
        }
    }
}
