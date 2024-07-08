//
//  Nameable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Nameable {
    var name : String { get }
    var customName : String? { get set }
    var displayName : String? { get set }
}
public extension Nameable {
    var hasCustomName : Bool {
        return customName != nil
    }
    
    var displayName : String? {
        return nil
    }
}
