//
//  CPMPSetHeldItem.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Sent to change the player's slot selection.
    struct SetHeldItem : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.set_held_item
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let slot:Int8 = try packet.read_byte()
            return Self(slot: slot)
        }
        
        /// The slot which the player has selected (0–8).
        public let slot:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [slot]
        }
    }
}
