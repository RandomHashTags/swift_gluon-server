//
//  EventType.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol EventType : Hashable, Identifiable {
    static func parse(_ identifier: String) -> Self?
}
