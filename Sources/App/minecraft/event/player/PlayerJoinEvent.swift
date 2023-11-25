//
//  PlayerJoinEvent.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol PlayerJoinEvent : PlayerEvent {
    init(_ player: any Player)
}
