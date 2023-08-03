//
//  StatisticActive.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol StatisticActive : Codable, Identifiable where ID == String {
    var type : (any Statistic)? { get }
    var value : Float { get }
}
