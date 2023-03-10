//
//  GameRule.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct GameRule : Jsonable {
    public let identifier:String
    public let value_type:ValueType
    
    public var value_boolean:Bool?
    public var value_integer:Int?
}
