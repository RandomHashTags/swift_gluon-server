//
//  EventCancellable.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public class EventCancellable : Event, Cancellable {
    public var is_cancelled:Bool
    
    public init(type: EventType, is_cancelled: Bool) {
        self.is_cancelled = is_cancelled
        super.init(type: type)
    }
}
