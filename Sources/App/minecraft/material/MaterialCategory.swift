//
//  MaterialCategory.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialCategory : Hashable, Identifiable where ID == String {
    var configuration_id : String { get }
    var configuration : (any MaterialConfiguration)? { get }
}

public extension MaterialCategory {
    static func == (left: any MaterialCategory, right: any MaterialCategory) -> Bool {
        return left.id.elementsEqual(right.id)
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
