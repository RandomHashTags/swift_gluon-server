//
//  CPMLLoginSuccess.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// This packet switches the connection state to play.
    /// - Warning: The (notchian) server might take a bit to fully transition to the Play state, so it's recommended to wait for the Login (play) packet from the server.
    /// - Warning: The notchian client doesn't send any packets until the Login (play) packet.
    struct LoginSuccess : ClientPacketMojangLoginProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let uuid:UUID = try packet.read_uuid()
            let username:String = try packet.read_string()
            let number_of_properties:VariableInteger = try packet.read_var_int()
            let properties:[LoginSuccess.Property] = try packet.read_map(count: number_of_properties) {
                let name:String = try packet.read_string()
                let value:String = try packet.read_string()
                let is_signed:Bool = try packet.read_bool()
                let signature:String? = is_signed ? try packet.read_string() : nil
                return LoginSuccess.Property(name: name, value: value, is_signed: is_signed, signature: signature)
            }
            return Self(uuid: uuid, username: username, number_of_properties: number_of_properties, properties: properties)
        }
        
        public let uuid:UUID
        public let username:String
        /// Number of elements in `properties`.
        public let number_of_properties:VariableInteger
        public let properties:[LoginSuccess.Property]
        
        public struct Property : Hashable, Codable, PacketEncodableMojang {
            public let name:String
            public let value:String
            public let is_signed:Bool
            /// Only if `is_signed` is `true`.
            public let signature:String?
            
            public func packet_bytes() throws -> [UInt8] {
                var array:[UInt8] = []
                array.append(contentsOf: try name.packet_bytes())
                array.append(contentsOf: try value.packet_bytes())
                array.append(contentsOf: try is_signed.packet_bytes())
                if is_signed {
                    guard let signature:String = signature else {
                        throw GeneralPacketError.optional_value_cannot_be_optional(type: Self.self, value: "signature", precondition: "is_signed == true")
                    }
                    array.append(contentsOf: try signature.packet_bytes())
                }
                return array
            }
        }
        
        public var encoded_values : [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [uuid, username, number_of_properties]
            array.append(contentsOf: properties)
            return array
        }
    }
}
