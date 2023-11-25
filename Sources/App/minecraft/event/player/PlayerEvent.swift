//
//  PlayerEvent.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol PlayerEvent : Event {
    var player : any Player { get }
}
