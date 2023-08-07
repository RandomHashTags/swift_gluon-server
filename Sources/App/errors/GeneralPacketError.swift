//
//  GeneralPacketError.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

public enum GeneralPacketError : Error, CustomStringConvertible {
    case varint_is_too_big
    case namespace_value_length_not_equal
    case invalid_uuid(string: String)
    
    case command_node_missing_redirect_node
    case command_suggestions_response_match_missing_tooltip
    case login_success_missing_signature
    
    case not_implemented(packet_type: any Packet.Type)
    
    public var description : String {
        switch self {
        case .varint_is_too_big:
            return "VarInt is too big"
        case .namespace_value_length_not_equal:
            return "Namespace value length not equal to 2"
        case .invalid_uuid(let string):
            return "Invalid UUID format: " + string
            
        case .command_node_missing_redirect_node:
            return "CommandNode is missing its redirect_node value (precondition `flags & 0x08` is met)"
        case .command_suggestions_response_match_missing_tooltip:
            return "Missing `tooltip` value on a `ClientPacketMojang.Play.CommandSuggestionsResponse.Match` where `has_tooltip` == true"
        case .login_success_missing_signature:
            return "Missing `signature` value on a signed `ClientPacketMojang.Login.LoginStatus.Property`"
            
        case .not_implemented(let packet_type):
            return "`parse(_ packet)` not implemented for `Packet` implementation type: \(packet_type)"
        }
    }
}
