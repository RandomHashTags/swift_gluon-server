//
//  CPMPUpdateScore.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// This is sent to the client when it should update a scoreboard item.
    struct UpdateScore : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_score
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entity_name:String = try packet.read_string()
            let action:UpdateScore.Action = try packet.read_enum()
            let objective_name:String = try packet.read_string()
            let value:VariableInteger?
            if action != .remove_item {
                value = try packet.read_var_int()
            } else {
                value = nil
            }
            return Self(entity_name: entity_name, action: action, objective_name: objective_name, value: value)
        }
        
        /// The entity whose score this is. For players, this is their username; for other entities, it is their UUID.
        public let entity_name:String
        public let action:UpdateScore.Action
        /// The name of the objective the score belongs to.
        public let objective_name:String
        /// The score to be displayed next to the entry. Only sent when Action does not equal 1.
        public let value:VariableInteger?
        
        public enum Action : Int, Hashable, Codable, PacketEncodableMojang {
            case create_or_update_item = 0
            case remove_item = 1
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [entity_name, action, objective_name]
            if action != .remove_item {
                let value:VariableInteger = try unwrap_optional(value, key_path: \Self.value, precondition: "action.rawValue != 1")
                array.append(value)
            }
            return array
        }
    }
}
