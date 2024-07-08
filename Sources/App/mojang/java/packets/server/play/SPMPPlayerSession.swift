//
//  SPMPPlayerSession.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    struct PlayerSession : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.player_session
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let session_id:UUID = try packet.readUUID()
            let expires_at:Int64 = try packet.readLong()
            let publicKeyLength:VariableIntegerJava = try packet.readVarInt()
            let publicKey:[UInt8] = try packet.read_byte_array(bytes: publicKeyLength)
            let key_signature_length:VariableIntegerJava = try packet.readVarInt()
            let key_signature:[UInt8] = try packet.read_byte_array(bytes: key_signature_length)
            return Self(session_id: session_id, expires_at: expires_at, publicKeyLength: publicKeyLength, publicKey: publicKey, key_signature_length: key_signature_length, key_signature: key_signature)
        }
        
        public let session_id:UUID
        /// The time the play session key expires in [epoch](https://en.wikipedia.org/wiki/Unix_time) milliseconds.
        public let expires_at:Int64
        /// Length of the proceeding public key. Maximum length in Notchian server is 512 bytes.
        public let publicKeyLength:VariableIntegerJava
        /// A byte array of an X.509-encoded public key.
        public let publicKey:[UInt8]
        /// Length of the proceeding key signature array. Maximum length in Notchian server is 4096 bytes.
        public let key_signature_length:VariableIntegerJava
        /// The signature consists of the player UUID, the key expiration timestamp, and the public key data. These values are hashed using [SHA-1](https://en.wikipedia.org/wiki/SHA-1) and signed using Mojang's private [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) key.
        public let key_signature:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[any PacketEncodableMojangJava] = [session_id, expires_at, publicKeyLength]
            array.append(contentsOf: publicKey)
            array.append(key_signature_length)
            array.append(contentsOf: key_signature)
            return array
        }
    }
}
