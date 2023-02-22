//
//  EventCancellable.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol EventCancellable : Event, Cancellable {
    var is_cancelled:Bool { get set }
}
