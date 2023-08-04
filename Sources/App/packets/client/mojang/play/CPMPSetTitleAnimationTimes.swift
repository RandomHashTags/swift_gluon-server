//
//  CPMPSetTitleAnimationTimes.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct SetTitleAnimationTimes : ClientPacketMojangPlayProtocol {
        /// Ticks to spend fading in.
        public let fade_in:Int
        /// Ticks to keep the title displayed.
        public let stay:Int
        /// Ticks to spend fading out, not when to start fading out.
        public let fade_out:Int
    }
}
