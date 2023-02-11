//
//  StatisticActive.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct StatisticActive : Jsonable {
    public let identifier:String
    public var type : Statistic? {
        return GluonServer.get_statistic(identifier: identifier)
    }
    public var value:Float
}
