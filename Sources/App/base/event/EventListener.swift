//
//  EventListener.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EventListener {
    var priority:Int { get }
    func handle(event: any Event)
}

public extension EventListener {
    var priority : UInt8 {
        return UInt8.max / 2
    }
    func handle(event: any Event) {
    }
}
