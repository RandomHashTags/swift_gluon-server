//
//  SPMPSwingArm.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when the player's arm swings.
    struct SwingArm : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.swing_arm
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let hand:SwingArm.Hand = try packet.read_enum()
            return Self(hand: hand)
        }
        
        public let hand:SwingArm.Hand
        
        public enum Hand : Int, Hashable, Codable, PacketEncodableMojang {
            case main_hand
            case off_hand
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [hand]
        }
    }
}
