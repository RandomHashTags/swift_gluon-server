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
        public let count:Int
        public let statistics:AwardStatistics.Statistic
        
        public struct Statistic : Hashable, Codable {
            public let category_id:[Int]
            public let statistic_id:[Int]
            public let value:[Int]
        }
    }
}
