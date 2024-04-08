//
//  GluonStatisticActive.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

struct GluonStatisticActive : StatisticActive {
    let id:String
    var type : (any Statistic)? {
        return GluonServer.shared.get_statistic(identifier: id)
    }
    var value:Float
}
