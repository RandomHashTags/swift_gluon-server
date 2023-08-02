//
//  CMPBossBar.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientMojangPacket {
    struct BossBar : ClientMojangPacketProtocol {
        /// Unique ID for this bar.
        let uuid:UUID
        /// Determines the layout of the remaining packet.
        let action:BossBar.Action
        
        // add, update_title
        let title:ChatPacket?
        // add, update_health
        /// From 0 to 1. Values greater than 1 do not crash a Notchian client, and start rendering part of a second health bar at around 1.5.
        let health:Float?
        // add, update_style
        /// Color ID.
        let color:BossBar.Color?
        // add
        /// Type of division.
        let division:BossBar.Division?
        // add, update_flags
        /// Bit mask. 0x1: should darken sky, 0x2: is dragon bar (used to play end music), 0x04: create fog (previously was also controlled by 0x02).
        let flags:UInt?
        
        enum Action : UInt, Hashable, Codable {
            case add = 0
            case remove
            case update_health
            case update_title
            case update_style
            case update_flags
        }
        enum Color : UInt, Hashable, Codable {
            case pink = 0
            case blue
            case red
            case green
            case yellow
            case purple
            case white
        }
        enum Division : UInt, Hashable, Codable {
            case no_division = 0
            case six_notches
            case ten_notches
            case twelve_notches
            case twenty_notches
        }
    }
}
