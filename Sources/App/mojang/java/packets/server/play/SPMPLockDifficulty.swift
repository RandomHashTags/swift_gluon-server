//
//  SPMPLockDifficulty.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    /// Must have at least op level 2 to use. Appears to only be used on singleplayer; the difficulty buttons are still disabled in multiplayer.
    struct LockDifficulty : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.lock_difficulty
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let locked:Bool = try packet.read_bool()
            return Self(locked: locked)
        }
        
        public let locked:Bool
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [locked]
        }
    }
}
