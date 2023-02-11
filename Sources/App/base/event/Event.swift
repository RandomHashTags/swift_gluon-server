//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/11/23.
//

import Foundation

public class Event {
    public let type:EventType, is_async:Bool
    
    public init(type: EventType, is_async: Bool) {
        self.type = type
        self.is_async = is_async
    }
}
