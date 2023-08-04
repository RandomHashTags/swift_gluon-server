//
//  CPMPSetSimulationDistance.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetSimulationDistance : ClientPacketMojangPlayProtocol {
        /// The distance that the client will process specific things, such as entities.
        public let distance:Int
    }
}
