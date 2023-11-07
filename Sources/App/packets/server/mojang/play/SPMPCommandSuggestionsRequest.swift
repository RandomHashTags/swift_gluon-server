//
//  SPMPCommandSuggestionsRequest.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    struct CommandSuggestionsRequest : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.command_suggestions_request
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let transaction_id:VariableInteger = try packet.read_var_int()
            let text:String = try packet.read_string()
            return Self(transaction_id: transaction_id, text: text)
        }
        
        /// The id of the transaction that the server will send back to the client in the response of this packet. Client generates this and increments it each time it sends another tab completion that doesn't get a response.
        public let transaction_id:VariableInteger
        /// All text behind the cursor without the `/` (e.g. to the left of the cursor in left-to-right languages like English).
        public let text:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [transaction_id, text]
        }
    }
}
