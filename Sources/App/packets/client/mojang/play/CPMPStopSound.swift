//
//  CPMPStopSound.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct StopSound : ClientPacketMojangPlayProtocol {
        /// Controls which fields are present.
        public let flags:Int
        /// Only if flags is 3 or 1 (bit mask 0x1). See below. If not present, then sounds from all sources are cleared.
        public let source:Int?
        /// Only if flags is 2 or 3 (bit mask 0x2). A sound effect name, see Custom Sound Effect. If not present, then all sounds are cleared.
        public let sound:String?
    }
}
