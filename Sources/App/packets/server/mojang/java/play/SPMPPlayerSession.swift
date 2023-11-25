//
//  SPMPPlayerSession.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacket.Mojang.Java.Play {
    struct PlayerSession : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.player_session
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let session_id:UUID = try packet.read_uuid()
            let expires_at:Int64 = try packet.read_long()
            let public_key_length:VariableInteger = try packet.read_var_int()
            let public_key:[UInt8] = try packet.read_byte_array(bytes: public_key_length)
            let key_signature_length:VariableInteger = try packet.read_var_int()
            let key_signature:[UInt8] = try packet.read_byte_array(bytes: key_signature_length)
            return Self(session_id: session_id, expires_at: expires_at, public_key_length: public_key_length, public_key: public_key, key_signature_length: key_signature_length, key_signature: key_signature)
        }
        
        public let session_id:UUID
        /// The time the play session key expires in [epoch](https://en.wikipedia.org/wiki/Unix_time) milliseconds.
        public let expires_at:Int64
        /// Length of the proceeding public key. Maximum length in Notchian server is 512 bytes.
        public let public_key_length:VariableInteger
        /// A byte array of an X.509-encoded public key.
        public let public_key:[UInt8]
        /// Length of the proceeding key signature array. Maximum length in Notchian server is 4096 bytes.
        public let key_signature_length:VariableInteger
        /// The signature consists of the player UUID, the key expiration timestamp, and the public key data. These values are hashed using [SHA-1](https://en.wikipedia.org/wiki/SHA-1) and signed using Mojang's private [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) key.
        public let key_signature:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[any PacketEncodableMojang] = [session_id, expires_at, public_key_length]
            array.append(contentsOf: public_key)
            array.append(key_signature_length)
            array.append(contentsOf: key_signature)
            return array
        }
    }
}
