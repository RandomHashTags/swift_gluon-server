//
//  Nameable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Nameable {
    var name : String { get }
    var custom_name : String? { get set }
    var display_name : String? { get set }
}
public extension Nameable {
    var has_custom_name : Bool {
        return custom_name != nil
    }
    
    var display_name : String? {
        return nil
    }
}
