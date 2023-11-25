//
//  SPMPPlayerAbilities.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// The vanilla client sends this packet when the player starts/stops flying with the Flags parameter changed accordingly.
    struct PlayerAbilities : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.player_abilities
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let flags:Int8 = try packet.read_byte()
            return Self(flags: flags)
        }
        
        /// Bit mask. 0x02: is flying.
        public let flags:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [flags]
        }
    }
}
