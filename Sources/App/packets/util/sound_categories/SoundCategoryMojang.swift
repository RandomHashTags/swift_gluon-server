//
//  SoundCategoryMojang.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public enum SoundCategoryMojang : Int, Hashable, Codable, PacketEncodableMojang {
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
