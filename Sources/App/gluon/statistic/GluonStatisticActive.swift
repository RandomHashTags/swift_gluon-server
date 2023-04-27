//
//  GluonStatisticActive.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

struct GluonStatisticActive : StatisticActive {
    typealias TargetStatistic = GluonStatistic
    
    let identifier:String
    var type : GluonStatistic? {
        return GluonServer.shared_instance.get_statistic(identifier: identifier)
    }
    var value:Float
}
