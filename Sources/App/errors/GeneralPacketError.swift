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
    
    case not_implemented(packet_type: any Packet.Type)
    
    public var description : String {
        switch self {
        case .varint_is_too_big:
            return "VarInt is too big"
        case .namespace_value_length_not_equal:
            return "Namespace value length not equal to 2"
        case .invalid_uuid(let string):
            return "Invalid UUID format: " + string
        case .not_implemented(let packet_type):
            return "`parse(_ packet)` not implemented for `Packet` implementation type: \(packet_type)"
        }
    }
}
