//
//  EntityEvent.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol EntityEvent : Event {
    var entity : any Entity { get }
}
