//
//  CPMPDisplayObjective.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This is sent to the client when it should display a scoreboard.
    struct DisplayObjective : ClientPacketMojangPlayProtocol {
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.display_objective
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let position:Int8 = try packet.read_byte()
            let score_name:String = try packet.read_string()
            return Self(position: position, score_name: score_name)
        }
        
        /// The position of the scoreboard. 0: list, 1: sidebar, 2: below name, 3 - 18: team specific sidebar, indexed as 3 + team color.
        public let position:Int8
        /// The unique name for the scoreboard to be displayed.
        public let score_name:String
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [position, score_name]
        }
    }
}
