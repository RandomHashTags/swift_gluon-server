//
//  Nameable.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public class Nameable : Jsonable {
    public static func == (lhs: Nameable, rhs: Nameable) -> Bool {
        return lhs.custom_name == rhs.custom_name
    }
    
    public var custom_name:String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(custom_name)
    }
    
    public init(custom_name: String?) {
        self.custom_name = custom_name
    }
}
