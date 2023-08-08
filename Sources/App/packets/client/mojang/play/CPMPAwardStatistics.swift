//
//  CPMPAwardStatistics.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent as a response to Client Command (id 1). Will only send the changed values if previously requested.
    struct AwardStatistics : ClientPacketMojangPlayProtocol {
        /// Number of elements in `statistics`.
        public let count:VariableInteger
        public let statistics:[AwardStatistics.Statistic]
        
        public struct Statistic : Hashable, Codable, PacketEncodableMojang {
            public let category_id:VariableInteger
            public let statistic_id:VariableInteger
            public let value:VariableInteger
            
            public func packet_bytes() throws -> [UInt8] {
                var bytes:[UInt8] = try category_id.packet_bytes()
                bytes.append(contentsOf: try statistic_id.packet_bytes())
                bytes.append(contentsOf: try value.packet_bytes())
                return bytes
            }
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [count]
            array.append(contentsOf: statistics)
            return array
        }
    }
}
