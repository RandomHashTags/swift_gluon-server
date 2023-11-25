//
//  GeneralPacketError.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

public enum GeneralPacketError : Error, CustomStringConvertible {
    case varint_is_too_big
    case varlong_is_too_big
    case namespace_value_length_not_equal
    case invalid_uuid(string: String)
    
    case optional_value_cannot_be_optional(type: Any.Type, value: String, precondition: String)
    
    case not_implemented(packet_type: any Packet.Type)
    
    public var description : String {
        switch self {
        case .varint_is_too_big:
            return "VarInt is too big"
        case .varlong_is_too_big:
            return "VarLong is too big"
        case .namespace_value_length_not_equal:
            return "Namespace value length not equal to 2"
        case .invalid_uuid(let string):
            return "Invalid UUID format: " + string
            
        case .optional_value_cannot_be_optional(let type, let value, let precondition):
            return "Optional value `" + value + "` in `\(type)` cannot be nil when " + precondition
            
        case .not_implemented(let packet_type):
            return "`parse(_ packet)` not implemented for `Packet` implementation type: \(packet_type)"
        }
    }
}
