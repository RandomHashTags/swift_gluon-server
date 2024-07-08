//
//  SPMPMessageAcknowledgment.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    struct MessageAcknowledgment : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.message_acknowledgement
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let message_count:VariableIntegerJava = try packet.readVarInt()
            return Self(message_count: message_count)
        }
        
        public let message_count:VariableIntegerJava
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [message_count]
        }
    }
}
