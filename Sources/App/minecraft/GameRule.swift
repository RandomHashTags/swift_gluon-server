//
//  GameRule.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct GameRule : Identifiable, Hashable {
    public let id:String
    public let valueType:ValueType
    
    public var valueBoolean : Bool?
    public var valueInteger : Int?
}