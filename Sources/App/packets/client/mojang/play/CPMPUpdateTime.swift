//
//  CPMPUpdateTime.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Time is based on ticks, where 20 ticks happen every second. There are 24000 ticks in a day, making Minecraft days exactly 20 minutes long.
    ///
    /// The time of day is based on the timestamp modulo 24000. 0 is sunrise, 6000 is noon, 12000 is sunset, and 18000 is midnight.
    ///
    /// The default SMP server increments the time by `20` every second.
    struct UpdateTime : ClientPacketMojangPlayProtocol {
        /// In ticks; not changed by server commands.
        public let world_age:Int64
        /// The world (or region) time, in ticks. If negative the sun will stop moving at the Math.abs of the time.
        public let time_of_day:Int64
    }
}
