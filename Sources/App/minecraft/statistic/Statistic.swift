//
//  Statistic.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Statistic : MultilingualName, Identifiable where ID == String {
    var value_type : ValueType { get }
}
