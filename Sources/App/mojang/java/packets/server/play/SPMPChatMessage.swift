//
//  SPMPChatMessage.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    /// Used to send a chat message to the server. The message may not be longer than 256 characters or else the server will kick the client.
    ///
    /// The server will broadcast the same chat message to all players on the server (including the player that sent the message), prepended with player's name. Specifically, it will respond with a translate chat component, "chat.type.text" with the first parameter set to the display name of the player (including some chat component logic to support clicking the name to send a PM) and the second parameter set to the message. See [processing chat](https://wiki.vg/Chat#Processing_chat) for more information.
    struct ChatMessage : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.chat_message
        
        public let message:String
        public let timestamp:Int64
        /// The salt used to verify the signature hash.
        public let salt:Int64
        public let has_signature:Bool
        /// The signature used to verify the chat message's authentication. When present, always 256 bytes and not length-prefixed.
        public let signature:[UInt8]?
        public let message_count:VariableIntegerJava
        public let acknowledged:[UInt8] // TODO: make BitSet
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [
                message,
                timestamp,
                salt,
                has_signature
            ]
            if has_signature {
                let signature:[UInt8] = try unwrap_optional(signature, key_path: \Self.signature, precondition: "has_signature == true")
                array.append(contentsOf: signature)
            }
            array.append(message_count)
            array.append(contentsOf: acknowledged)
            return array
        }
    }
}
