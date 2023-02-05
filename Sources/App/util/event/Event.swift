//
//  Event.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol Event : Hashable {
    var is_async:Bool { get }
}
