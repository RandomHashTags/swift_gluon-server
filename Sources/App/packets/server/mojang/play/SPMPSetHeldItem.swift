//
//  SPMPSetHeldItem.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when the player changes the slot selection.
    struct SetHeldItem : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.set_held_item
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let slot:Int16 = try packet.read_short()
            return Self(slot: slot)
        }
        
        /// The slot which the player has selected (0–8).
        public let slot:Int16
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [slot]
        }
    }
}
