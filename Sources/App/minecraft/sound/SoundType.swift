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
    var sound_break : SoundEventType { get }
    var sound_step : SoundEventType { get }
    var sound_place : SoundEventType { get }
    var sound_hit : SoundEventType { get }
    var sound_fall : SoundEventType { get }
}
