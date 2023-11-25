//
//  CPMPChangeDifficulty.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Changes the difficulty setting in the client's option menu.
    struct ChangeDifficulty : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.change_difficulty
        
        public let difficulty:ChangeDifficulty.Difficulty
        public let difficulty_locked:Bool
        
        public enum Difficulty : UInt8, Codable, PacketEncodableMojangJava {
            case peaceful = 0
            case easy
            case normal
            case hard
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [difficulty, difficulty_locked]
        }
    }
}
