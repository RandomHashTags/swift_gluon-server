//
//  CPMPSetHealth.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server to set the health of the player it is sent to.
    ///
    /// Food saturation acts as a food “overcharge”. Food values will not decrease while the saturation is over zero. New players logging in or respawning automatically get a saturation of 5.0. Eating food increases the saturation as well as the food bar.
    struct SetHealth : ClientPacketMojangPlayProtocol {
        /// 0 or less = dead, 20 = full HP.
        public let health:Float
        /// 0–20.
        public let food:Int
        /// Seems to vary from 0.0 to 5.0 in integer increments.
        public let food_saturation:Float
    }
}
