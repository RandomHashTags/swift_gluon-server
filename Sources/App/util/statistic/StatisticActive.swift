//
//  StatisticActive.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public class StatisticActive : Hashable {
    public static func == (lhs: StatisticActive, rhs: StatisticActive) -> Bool {
        return lhs.type == rhs.type
    }
    
    public let type:UnsafePointer<Statistic>
    
    public init(type: UnsafePointer<Statistic>) {
        self.type = type
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
