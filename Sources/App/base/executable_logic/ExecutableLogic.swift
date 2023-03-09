//
//  ExecutableLogic.swift
//  
//
//  Created by Evan Anderson on 3/5/23.
//

import Foundation

public struct ExecutableLogic : Jsonable { // TODO: add to `GluonServer` for global executable logical identifiers
    /// The user-friendly lowercased string representation that is used to do logic upon certain events.
    public let string:String
    
    func execute(context: [String:ExecutableLogicalContext]) {
    }
}

public struct ExecutableLogicBuilder {
    static func parse(json: [String:[String]]) {
        for (event_identifier, logic) in json {
            if let event_type:EventType = EventType.parse(event_identifier) {
                // TODO: register executable logic for event `event_type` to `GluonServer`
            }
        }
    }
}
