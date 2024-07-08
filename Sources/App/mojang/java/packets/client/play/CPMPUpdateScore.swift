//
//  CPMPUpdateScore.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This is sent to the client when it should update a scoreboard item.
    struct UpdateScore : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_score
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let entityName:String = try packet.readString()
            let action:UpdateScore.Action = try packet.readEnum()
            let objectiveName:String = try packet.readString()
            let value:VariableIntegerJava?
            if action != .remove_item {
                value = try packet.readVarInt()
            } else {
                value = nil
            }
            return Self(entityName: entityName, action: action, objectiveName: objectiveName, value: value)
        }
        
        /// The entity whose score this is. For players, this is their username; for other entities, it is their UUID.
        public let entityName:String
        public let action:UpdateScore.Action
        /// The name of the objective the score belongs to.
        public let objectiveName:String
        /// The score to be displayed next to the entry. Only sent when Action does not equal 1.
        public let value:VariableIntegerJava?
        
        public enum Action : Int, Codable, PacketEncodableMojangJava {
            case create_or_update_item = 0
            case remove_item = 1
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [entityName, action, objectiveName]
            if action != .remove_item {
                let value:VariableIntegerJava = try unwrap_optional(value, key_path: \Self.value, precondition: "action.rawValue != 1")
                array.append(value)
            }
            return array
        }
    }
}
