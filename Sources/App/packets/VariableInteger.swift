//
//  VariableInteger.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

/// An integer between -2147483648 and 2147483647.
///
/// Variable-length data encoding a two's complement signed 32-bit integer.
public struct VariableInteger : Hashable, Codable, PacketEncodableMojang, PacketDecodableMojang {
    public static func decode(from packet: GeneralPacketMojang) throws -> Self {
        return try packet.read_var_int()
    }
    
    public let value:Int32
    
    public var value_int : Int {
        return Int(value)
    }
    
    public init(value: Int32) {
        self.value = value
    }
    
    public func packet_bytes() throws -> [UInt8] {
        return try value.packet_bytes()
    }
}
