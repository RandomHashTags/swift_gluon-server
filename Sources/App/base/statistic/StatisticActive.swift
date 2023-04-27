//
//  StatisticActive.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol StatisticActive : Jsonable, Identifiable {
    associatedtype TargetStatistic : Statistic
    
    var type : TargetStatistic? { get }
    var value : Float { get }
}
