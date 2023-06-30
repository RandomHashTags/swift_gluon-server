//
//  MaterialConfiguration.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol MaterialConfiguration : Hashable, Identifiable where ID == String {
    var is_only_item : Bool { get }
    var is_only_block : Bool { get }
    var is_block_and_item : Bool { get }
    
    var item : (any MaterialItemConfiguration)? { get }
    var block : (any MaterialBlockConfiguration)? { get }
}
public extension MaterialConfiguration {
    var is_only_item : Bool { item != nil && block == nil }
    var is_only_block : Bool { item == nil && block != nil }
    var is_block_and_item : Bool { item != nil && block != nil }
}

public extension MaterialConfiguration {
    static func == (left: any MaterialConfiguration, right: any MaterialConfiguration) -> Bool {
        return left.id.elementsEqual(right.id)
    }
    static func == (left: Self, right: Self) -> Bool {
        return left == right
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
