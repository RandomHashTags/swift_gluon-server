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
        public let window_id:UInt8
        /// The property to be updated.
        public let property:Int
        /// The new value for the property.
        public let value:Int
    }
}
