//
//  PlayerGameModeChangeEvent.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol PlayerGameModeChangeEvent : PlayerEventCancellable {
    var new_game_mode : GameMode { get set }
}
