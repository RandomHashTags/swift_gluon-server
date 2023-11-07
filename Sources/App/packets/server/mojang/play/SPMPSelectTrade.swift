//
//  SPMPSelectTrade.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// When a player selects a specific trade offered by a villager NPC.
    struct SelectTrade : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.select_trade
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let selected_slot:VariableInteger = try packet.read_var_int()
            return Self(selected_slot: selected_slot)
        }
        
        /// The selected slot in the players current (trading) inventory. (Was a full Integer for the plugin message).
        public let selected_slot:VariableInteger
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [selected_slot]
        }
    }
}
