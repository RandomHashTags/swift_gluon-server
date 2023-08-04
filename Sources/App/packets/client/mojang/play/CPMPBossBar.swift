//
//  CPMPBossBar.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct BossBar : ClientPacketMojangPlayProtocol {
        /// Unique ID for this bar.
        public let uuid:UUID
        /// Determines the layout of the remaining packet.
        public let action:BossBar.Action
        
        // add, update_title
        public let title:ChatPacketMojang?
        // add, update_health
        /// From 0 to 1. Values greater than 1 do not crash a Notchian client, and start rendering part of a second health bar at around 1.5.
        public let health:Float?
        // add, update_style
        /// Color ID.
        public let color:BossBar.Color?
        // add
        /// Type of division.
        public let division:BossBar.Division?
        // add, update_flags
        /// Bit mask. 0x1: should darken sky, 0x2: is dragon bar (used to play end music), 0x04: create fog (previously was also controlled by 0x02).
        public let flags:UInt?
        
        public enum Action : UInt, Hashable, Codable {
            case add = 0
            case remove
            case update_health
            case update_title
            case update_style
            case update_flags
        }
        public enum Color : UInt, Hashable, Codable {
            case pink = 0
            case blue
            case red
            case green
            case yellow
            case purple
            case white
        }
        public enum Division : UInt, Hashable, Codable {
            case no_division = 0
            case six_notches
            case ten_notches
            case twelve_notches
            case twenty_notches
        }
    }
}
