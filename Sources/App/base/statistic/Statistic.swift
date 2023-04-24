//
//  Statistic.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol Statistic : Jsonable, Identifiable, MultilingualName {
    var value_type : ValueType { get }
}
