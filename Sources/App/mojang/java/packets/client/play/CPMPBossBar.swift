//
//  CPMPBossBar.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    struct BossBar : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.boss_bar
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let uuid:UUID = try packet.readUUID()
            let action:BossBar.Action = try packet.readEnum()
            var title:ChatPacketMojang? = nil
            var health:Float? = nil
            var color:Color? = nil
            var division:Division? = nil
            var flags:UInt8? = nil
            switch action {
            case .add:
                title = nil // TODO: fix
                health = try packet.readFloat()
                color = try packet.readEnum()
                division = try packet.readEnum()
                flags = try packet.readUnsignedByte()
                break
            case .remove:
                break
            case .update_health:
                health = try packet.readFloat()
                break
            case .update_title:
                title = nil // TODO: fix
                break
            case .update_style:
                color = try packet.readEnum()
                division = try packet.readEnum()
                break
            case .update_flags:
                flags = try packet.readUnsignedByte()
                break
            }
            return Self(uuid: uuid, action: action, title: title, health: health, color: color, division: division, flags: flags)
        }
        
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
        public let flags:UInt8?
        
        public enum Action : Int, Codable, PacketEncodableMojangJava {
            case add = 0
            case remove
            case update_health
            case update_title
            case update_style
            case update_flags
        }
        public enum Color : Int, Codable, PacketEncodableMojangJava {
            case pink = 0
            case blue
            case red
            case green
            case yellow
            case purple
            case white
        }
        public enum Division : Int, Codable, PacketEncodableMojangJava {
            case no_division = 0
            case six_notches
            case ten_notches
            case twelve_notches
            case twenty_notches
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [uuid, action]
            let secondary:[(any PacketEncodableMojangJava)?]
            switch action {
            case .add:
                secondary = [title, health, color, division, flags]
                break
            case .remove:
                secondary = []
                break
            case .update_health:
                secondary = [health]
                break
            case .update_title:
                secondary = [title]
                break
            case .update_style:
                secondary = [color, division]
                break
            case .update_flags:
                secondary = [flags]
                break
            }
            array.append(contentsOf: secondary)
            return array
        }
    }
}
