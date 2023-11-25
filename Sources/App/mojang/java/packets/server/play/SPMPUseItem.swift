//
//  SPMPUseItem.swift
//  
//
//  Created by Evan Anderson on 8/10/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Sent when pressing the Use Item key (default: right click) with an item in hand.
    struct UseItem : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.use_item
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let hand:UseItem.Hand = try packet.read_enum()
            let sequence:VariableIntegerJava = try packet.read_var_int()
            return Self(hand: hand, sequence: sequence)
        }
        
        public let hand:UseItem.Hand
        public let sequence:VariableIntegerJava
        
        public enum Hand : Int, Hashable, Codable, PacketEncodableMojangJava {
            case main_hand
            case off_hand
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [hand, sequence]
        }
    }
}
