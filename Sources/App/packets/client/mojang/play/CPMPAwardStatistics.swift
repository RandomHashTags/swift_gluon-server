//
//  CPMPAwardStatistics.swift
//
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent as a response to Client Command (id 1). Will only send the changed values if previously requested.
    struct AwardStatistics : ClientPacketMojangProtocol {
        /// Number of elements in `statistics`.
        let count:Int
        let statistics:AwardStatistics.Statistic
        
        struct Statistic : Hashable, Codable {
            let category_id:[Int]
            let statistic_id:[Int]
            let value:[Int]
        }
    }
}
