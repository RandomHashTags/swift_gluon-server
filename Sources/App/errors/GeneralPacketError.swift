//
//  GeneralPacketError.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

public enum GeneralPacketError : Error, CustomStringConvertible {
    case varint_is_too_big
    
    case not_implemented(packet_type: any Packet.Type)
    
    public var description : String {
        switch self {
        case .varint_is_too_big:
            return "VarInt is too big"
        case .not_implemented(let packet_type):
            return "`parse(_ packet)` not implemented for `Packet` implementation type: \(packet_type)"
        }
    }
}
