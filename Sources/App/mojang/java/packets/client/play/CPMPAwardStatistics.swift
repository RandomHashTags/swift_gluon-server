//
//  CPMPAwardStatistics.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Play {
    /// Sent as a response to Client Command (id 1). Will only send the changed values if previously requested.
    struct AwardStatistics : ClientPacketMojangJavaPlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.award_statistic
        
        /// Number of elements in `statistics`.
        public let count:VariableIntegerJava
        public let statistics:[AwardStatistics.Statistic]
        
        public struct Statistic : Hashable, Codable, PacketEncodableMojangJava {
            public let category_id:VariableIntegerJava
            public let statistic_id:VariableIntegerJava
            public let value:VariableIntegerJava
            
            public func packet_bytes() throws -> [UInt8] {
                var bytes:[UInt8] = try category_id.packet_bytes()
                bytes.append(contentsOf: try statistic_id.packet_bytes())
                bytes.append(contentsOf: try value.packet_bytes())
                return bytes
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [count]
            array.append(contentsOf: statistics)
            return array
        }
    }
}
