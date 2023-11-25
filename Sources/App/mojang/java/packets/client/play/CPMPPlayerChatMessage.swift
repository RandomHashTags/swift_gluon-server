//
//  CPMPPlayerChatMessage.swift
//  
//
//  Created by Evan Anderson on 8/8/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct PlayerChatMessage : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.player_chat_message
        
        // MARK: Header
        /// Used by the Notchian client for the disableChat launch option. Setting both longs to 0 will always display the message regardless of the setting.
        public let sender:UUID
        public let index:VariableIntegerJava
        public let message_signature_present:Bool
        /// Only present if `message_signature_present` is true. Cryptography, the signature consists of the Sender UUID, Session UUID from the [Player Session](https://wiki.vg/Protocol#Player_Session) packet, Index, Salt, Timestamp in epoch seconds, the length of the original chat content, the original content itself, the length of Previous Messages, and all of the Previous message signatures. These values are hashed with [SHA-256](https://en.wikipedia.org/wiki/SHA-2) and signed using the [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) cryptosystem. Modifying any of these values in the packet will cause this signature to fail. This buffer is always 256 bytes long and it is not length-prefixed.
        public let message_signature_bytes:[UInt8]?
        
        // MARK: Body
        public let message:String
        /// Represents the time the message was signed as milliseconds since the [epoch](https://en.wikipedia.org/wiki/Unix_time ), used to check if the message was received within 2 minutes of it being sent.
        public let timestamp:Int64
        /// Cryptography, used for validating the message signature.
        public let salt:Int64
        
        // MARK: Previous Messages
        /// The maximum length is 20 in Notchian client.
        public let total_previous_messages:VariableIntegerJava
        /// The message Id + 1, used for validating message signature. The next field is present only when value of this field is equal to -1.
        public let message_ids:[VariableIntegerJava]
        /// The previous message's signature. Contains the same type of data as `message_signature_bytes` above.
        public let signatures:[Int8]?
        
        // MARK: Other
        public let unsigned_content_present:Bool
        public let unsigned_content:ChatPacketMojang?
        /// If the message has been filtered
        public let filter_type:FilterType
        /// Only present if the Filter Type is Partially Filtered.
        public let filter_type_bits:Data? = nil // TODO: fix (make BitSet)
        
        // MARK: Network target
        /// The chat type from the [Login (play)](https://wiki.vg/Protocol#Login_.28play.29) packet used for this message
        public let chat_type:VariableIntegerJava
        public let network_name:ChatPacketMojang
        public let network_target_name_present:Bool
        public let network_target_name:ChatPacketMojang?
        
        public enum FilterType : Int, Codable, PacketEncodableMojangJava {
            case pass_through
            case fully_filtered
            case partially_filtered
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] { // TODO: fix
            var array:[(any PacketEncodableMojangJava)?] = [
                sender,
                index,
                message_signature_present
            ]
            if message_signature_present {
                let message_signature_bytes:[UInt8] = try unwrap_optional(message_signature_bytes, key_path: \Self.message_signature_bytes, precondition: "message_signature_present == true")
                array.append(contentsOf: message_signature_bytes)
            }
            
            var secondary:[(any PacketEncodableMojangJava)?] = [
                message,
                timestamp,
                salt,
                
                total_previous_messages
            ]
            secondary.append(contentsOf: message_ids)
            if total_previous_messages.value == -1 {
                let signatures:[Int8] = try unwrap_optional(signatures, key_path: \Self.signatures, precondition: "total_previous_messages.value == -1")
                secondary.append(contentsOf: signatures)
            }
            secondary.append(unsigned_content_present)
            if unsigned_content_present {
                let unsigned_content:ChatPacketMojang = try unwrap_optional(unsigned_content, key_path: \Self.unsigned_content, precondition: "unsigned_content_present == true")
                secondary.append(unsigned_content)
            }
            secondary.append(filter_type)
            if filter_type == .partially_filtered {
                let filter_type_bits:Data = try unwrap_optional(filter_type_bits, key_path: \Self.filter_type_bits, precondition: "filter_type == .partially_filtered")
                secondary.append(filter_type_bits)
            }
            array.append(contentsOf: secondary)
            
            secondary = [
                chat_type,
                network_name,
                network_target_name_present
            ]
            if network_target_name_present {
                let network_target_name:ChatPacketMojang = try unwrap_optional(network_target_name, key_path: \Self.network_target_name, precondition: "network_target_name_present == true")
                secondary.append(network_target_name)
            }
            array.append(contentsOf: secondary)
            
            return array
        }
    }
}
