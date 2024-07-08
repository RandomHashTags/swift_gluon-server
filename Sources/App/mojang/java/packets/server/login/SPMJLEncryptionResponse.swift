//
//  SPMJLEncryptionResponse.swift
//
//
//  Created by Evan Anderson on 11/6/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Login {
    /// See [Protocol Encryption](https://wiki.vg/Protocol_Encryption) for details. See [Mojang\_API#Player\_Certificates](https://wiki.vg/Mojang_API#Player_Certificates) for an API to get the message signature.
    struct EncryptionResponse : ServerPacketMojangJavaLoginProtocol {
        public static let id:ServerPacket.Mojang.Java.Login = ServerPacket.Mojang.Java.Login.encryption_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let shared_secret_length:VariableIntegerJava = try packet.readVarInt()
            let shared_secret:[UInt8] = try packet.read_byte_array(bytes: shared_secret_length)
            let verifyTokenLength:VariableIntegerJava = try packet.readVarInt()
            let verifyToken:[UInt8] = try packet.read_byte_array(bytes: verifyTokenLength)
            return Self(shared_secret_length: shared_secret_length, shared_secret: shared_secret, verifyTokenLength: verifyTokenLength, verifyToken: verifyToken)
        }
        
        let shared_secret_length:VariableIntegerJava
        /// Shared Secret value, encrypted with the server's public key.
        let shared_secret:[UInt8]
        let verifyTokenLength:VariableIntegerJava
        /// Verify Token value, encrypted with the same public key as the shared secret.
        let verifyToken:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var values:[any PacketEncodableMojangJava] = [shared_secret_length]
            values.append(contentsOf: shared_secret)
            values.append(verifyTokenLength)
            values.append(contentsOf: verifyToken)
            return values
        }
    }
}
