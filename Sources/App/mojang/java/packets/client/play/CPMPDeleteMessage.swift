//
//  CPMPDeleteMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Removes a message from the client's chat. This only works for messages with signatures, system messages cannot be deleted with this packet.
    struct DeleteMessage : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.delete_message
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let signatureLength:VariableIntegerJava = try packet.readVarInt()
            let signature:[UInt8] = try packet.read_byte_array(bytes: signatureLength)
            return Self(signatureLength: signatureLength, signature: signature)
        }
        
        /// Length of Signature.
        public let signatureLength:VariableIntegerJava
        /// Bytes of the signature.
        public let signature:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [signatureLength]
            array.append(contentsOf: signature)
            return array
        }
    }
}
