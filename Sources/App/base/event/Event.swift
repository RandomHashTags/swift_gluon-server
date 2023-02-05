//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Event {
    var is_async:Bool { get }
}
public extension Event {
    var is_async : Bool {
        get {
            return false
        }
    }
}
