//
//  SoundType.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

public protocol SoundType : Identifiable where ID == String {
    associatedtype SoundEventType : SoundEvent
    
    var volume : Float { get }
    var pitch : Float { get }
    var break_sound : SoundEventType { get }
    var step_sound : SoundEventType { get }
    var place_sound : SoundEventType { get }
    var hit_sound : SoundEventType { get }
    var fall_sound : SoundEventType { get }
}
