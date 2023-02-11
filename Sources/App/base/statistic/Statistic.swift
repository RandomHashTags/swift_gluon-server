//
//  Statistic.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Statistic : Jsonable {
    public let identifier:String
    public let name:MultilingualStrings
    public let value_type:ValueType
}
