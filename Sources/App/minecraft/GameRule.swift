//
//  GameRule.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol GameRule : Hashable, Identifiable where ID == String {
    var value_type : ValueType { get }
    
    var value_boolean : Bool? { get }
    var value_integer : Int? { get }
}

public extension GameRule {
    static func == (left: any GameRule, right: any GameRule) -> Bool {
        return left.id.elementsEqual(right.id)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
