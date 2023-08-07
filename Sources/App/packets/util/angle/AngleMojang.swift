//
//  AngleMojang.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

/// A rotation angle in steps of 1/256 of a full turn
public struct AngleMojang : Hashable, Codable, PacketEncodableMojang {
    /// Whether or not this is signed does not matter, since the resulting angles are the same.
    public let value:Int
    
    public func packet_bytes() throws -> [UInt8] {
        return [UInt8(value)]
    }
}
