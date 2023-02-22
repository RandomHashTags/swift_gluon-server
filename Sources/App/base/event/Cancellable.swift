//
//  Cancellable.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol Cancellable {
    var is_cancelled : Bool { get set }
}
public extension Cancellable {
    var is_cancelled : Bool {
        return false
    }
}
