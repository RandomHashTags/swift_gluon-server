//
//  CPMPDisplayObjective.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This is sent to the client when it should display a scoreboard.
    struct DisplayObjective : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.display_objective
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let position:Int8 = try packet.readByte()
            let scoreName:String = try packet.readString()
            return Self(position: position, scoreName: scoreName)
        }
        
        /// The position of the scoreboard. 0: list, 1: sidebar, 2: below name, 3 - 18: team specific sidebar, indexed as 3 + team color.
        public let position:Int8
        /// The unique name for the scoreboard to be displayed.
        public let scoreName:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [position, scoreName]
        }
    }
}
