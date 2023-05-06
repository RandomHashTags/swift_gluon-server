//
//  GluonEvent.swift
//  
//
//  Created by Evan Anderson on 5/6/23.
//

import Foundation

struct GluonEvent : Event {
    typealias TargetEventType = GluonEventType
    
    var type:TargetEventType
    var context:[String : ExecutableLogicalContext]?
}
