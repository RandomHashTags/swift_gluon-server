//
//  EventListener.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EventListener {
    var priority : UInt8 { get }
    func handle(event: any Event)
}

public extension EventListener {
    var priority : UInt8 {
        return EventPriority.normal
    }
    func handle(event: any Event) {
    }
}
