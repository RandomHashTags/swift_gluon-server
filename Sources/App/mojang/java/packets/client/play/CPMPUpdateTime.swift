//
//  CPMPUpdateTime.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Time is based on ticks, where 20 ticks happen every second. There are 24000 ticks in a day, making Minecraft days exactly 20 minutes long.
    ///
    /// The time of day is based on the timestamp modulo 24000. 0 is sunrise, 6000 is noon, 12000 is sunset, and 18000 is midnight.
    ///
    /// The default SMP server increments the time by `20` every second.
    struct UpdateTime : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.update_time
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let worldAge:Int64 = try packet.readLong()
            let timeOfDay:Int64 = try packet.readLong()
            return Self(worldAge: worldAge, timeOfDay: timeOfDay)
        }
        
        /// In ticks; not changed by server commands.
        public let worldAge:Int64
        /// The world (or region) time, in ticks. If negative the sun will stop moving at the Math.abs of the time.
        public let timeOfDay:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [worldAge, timeOfDay]
        }
    }
}
