//
//  EventListener.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EventListener {
    func handle(event: any Event)
}

public extension EventListener {
    func handle(event: any Event) {
    }
}
