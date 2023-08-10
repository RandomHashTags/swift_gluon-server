//
//  SPMPUseItem.swift
//  
//
//  Created by Evan Anderson on 8/10/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Sent when pressing the Use Item key (default: right click) with an item in hand.
    struct UseItem : ServerPacketMojangPlayProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let hand:UseItem.Hand = try packet.read_enum()
            let sequence:VariableInteger = try packet.read_var_int()
            return Self(hand: hand, sequence: sequence)
        }
        
        public let hand:UseItem.Hand
        public let sequence:VariableInteger
        
        public enum Hand : Int, Hashable, Codable, PacketEncodableMojang {
            case main_hand
            case off_hand
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [hand, sequence]
        }
    }
}
