//
//  SoundCategoryMojangJava.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

// https://wiki.vg/Protocol#Stop_Sound
public enum SoundCategoryMojangJava : Int, Codable, PacketEncodableMojangJava {
    case master = 0
    case music
    case record
    case weather
    case block
    case hostile
    case neutral
    case player
    case ambient
    case voice
}
