//
//  CPMPSetContainerProperty.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

/// This packet is used to inform the client that part of a GUI window should be updated.
public extension ClientPacketMojang.Play {
    struct SetContainerProperty : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let window_id:UInt8 = try packet.read_byte()
            let property:Int = try packet.read_short()
            let value:Int = try packet.read_short()
            return Self(window_id: window_id, property: property, value: value)
        }
        
        public let window_id:UInt8
        /// The property to be updated.
        public let property:Int
        /// The new value for the property.
        public let value:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            return [window_id, property, value]
        }
    }
}
