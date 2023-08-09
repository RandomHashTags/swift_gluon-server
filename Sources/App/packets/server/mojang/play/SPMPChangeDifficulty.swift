//
//  SPMPChangeDifficulty.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Must have at least op level 2 to use. Appears to only be used on singleplayer; the difficulty buttons are still disabled in multiplayer.
    struct ChangeDifficulty : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let new_difficulty:Int8 = try packet.read_byte()
            return Self(new_difficulty: new_difficulty)
        }
        
        /// 0: peaceful, 1: easy, 2: normal, 3: hard .
        public let new_difficulty:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [new_difficulty]
        }
    }
}
