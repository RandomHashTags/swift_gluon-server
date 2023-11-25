//
//  CPMPDeleteMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Removes a message from the client's chat. This only works for messages with signatures, system messages cannot be deleted with this packet.
    struct DeleteMessage : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.delete_message
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let signature_length:VariableInteger = try packet.read_var_int()
            let signature:[UInt8] = try packet.read_byte_array(bytes: signature_length)
            return Self(signature_length: signature_length, signature: signature)
        }
        
        /// Length of Signature.
        public let signature_length:VariableInteger
        /// Bytes of the signature.
        public let signature:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [signature_length]
            array.append(contentsOf: signature)
            return array
        }
    }
}
