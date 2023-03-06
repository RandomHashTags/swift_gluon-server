//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public protocol Event {
    var type:EventType { get }
    func get_context(key: String) -> ExecutableLogicalContext?
}
