//
//  ItemFlag.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol ItemFlag : Hashable, Identifiable where ID == String {
}

public extension ItemFlag {
    static func == (left: any ItemFlag, right: any ItemFlag) -> Bool {
        return left.id == right.id
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
