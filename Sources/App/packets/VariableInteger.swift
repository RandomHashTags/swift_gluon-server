//
//  VariableInteger.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public struct VariableInteger : Hashable, Codable, PacketEncodableMojang {
    public let value:Int
    
    public init(value: Int) {
        self.value = value
    }
    
    public func packet_bytes() throws -> [UInt8] {
        return try value.packet_bytes()
    }
}
