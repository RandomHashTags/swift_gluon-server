//
//  SPMPChatCommand.swift
//  
//
//  Created by Evan Anderson on 8/10/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    struct ChatCommand : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.chat_command
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> ServerPacket.Mojang.Java.Play.ChatCommand {
            let command:String = try packet.read_string()
            let timestamp:Int64 = try packet.read_long()
            let salt:Int64 = try packet.read_long()
            let array_length:VariableIntegerJava = try packet.read_var_int()
            let argument_names:[String] = try packet.read_string_array(count: array_length)
            let signature_byte_count:Int = 256
            let signatures:[[UInt8]] = try packet.read_map(count: array_length, transform: {
                return try packet.read_byte_array(bytes: signature_byte_count)
            })
            let message_count:VariableIntegerJava = try packet.read_var_int()
            let acknowledged:[UInt8] = try packet.read_remaining_byte_array()
            return Self(command: command, timestamp: timestamp, salt: salt, array_length: array_length, argument_names: argument_names, signatures: signatures, message_count: message_count, acknowledged: acknowledged)
        }
        
        /// The command typed by the client.
        public let command:String
        /// The timestamp that the command was executed.
        public let timestamp:Int64
        /// The salt for the following argument signatures.
        public let salt:Int64
        /// Number of entries in the following array. The maximum length in Notchian server is 8.
        public let array_length:VariableIntegerJava
        /// The name of the arguments that are signed by the following signature.
        public let argument_names:[String]
        /// The signatures that verify the arguments. Always 256 bytes and is not length-prefixed.
        public let signatures:[[UInt8]]
        public let message_count:VariableIntegerJava
        public let acknowledged:[UInt8] // TODO: make Fixed BitSet
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [command, timestamp, salt, array_length]
            array.append(contentsOf: argument_names)
            for signature in signatures {
                array.append(contentsOf: signature)
            }
            array.append(message_count)
            array.append(contentsOf: acknowledged)
            return array
        }
    }
}
