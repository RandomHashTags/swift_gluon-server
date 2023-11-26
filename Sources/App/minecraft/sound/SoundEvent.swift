//
//  SoundEvent.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

public protocol SoundEvent {
    static var default_range : Float { get }
    
    var range : Float { get }
}
