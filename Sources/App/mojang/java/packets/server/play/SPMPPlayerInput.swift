//
//  SPMPPlayerInput.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// !
    ///
    /// Also known as 'Input' packet.
    struct PlayerInput : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.player_input
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let sideways:Float = try packet.read_float()
            let forward:Float = try packet.read_float()
            let flags:UInt8 = try packet.read_unsigned_byte()
            return Self(sideways: sideways, forward: forward, flags: flags)
        }
        
        /// Positive to the left of the player.
        public let sideways:Float
        /// Positive forward.
        public let forward:Float
        /// Bit mask. 0x1: jump, 0x2: unmount.
        public let flags:UInt8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [sideways, forward, flags]
        }
    }
}
