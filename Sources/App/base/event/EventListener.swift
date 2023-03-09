//
//  EventListener.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EventListener {
    var priority:UInt8 { get }
    func handle(event: any Event)
}

public extension EventListener {
    var priority : UInt8 {
        return UInt8.normal_event_priority
    }
    func handle(event: any Event) {
    }
}
