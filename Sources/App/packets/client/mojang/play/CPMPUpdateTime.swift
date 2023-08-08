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
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let world_age:Int64 = try packet.read_long()
            let time_of_day:Int64 = try packet.read_long()
            return Self(world_age: world_age, time_of_day: time_of_day)
        }
        
        /// In ticks; not changed by server commands.
        public let world_age:Int64
        /// The world (or region) time, in ticks. If negative the sun will stop moving at the Math.abs of the time.
        public let time_of_day:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [world_age, time_of_day]
        }
    }
}
