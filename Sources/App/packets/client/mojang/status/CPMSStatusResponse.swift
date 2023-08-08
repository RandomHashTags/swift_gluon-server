//
//  CPMSStatusResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct StatusResponse : ClientPacketMojangStatusProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let json_response:String = try packet.read_string()
            return Self(json_response: json_response)
        }
        
        /// See https://wiki.vg/Server_List_Ping#Response ; as with all strings this is prefixed by its length as a VarInt.
        public let json_response:String
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [json_response]
        }
    }
}
