//
//  CPMPSetHeldItem.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent to change the player's slot selection.
    struct SetHeldItem : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let slot:Int8 = try packet.read_byte()
            return Self(slot: slot)
        }
        
        /// The slot which the player has selected (0–8).
        public let slot:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [slot]
        }
    }
}
