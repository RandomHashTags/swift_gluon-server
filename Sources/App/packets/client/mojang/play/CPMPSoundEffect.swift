//
//  CPMPSoundEffect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Plays a sound effect at the given location, either by hardcoded ID or Identifier. Sound IDs and names can be found at https://pokechu22.github.io/Burger/1.20.1.html#sounds .
    /// - Warning: Numeric sound effect IDs are liable to change between versions
    struct SoundEffect : ClientPacketMojangPlayProtocol {
        /// Represents the `Sound ID + 1`. If the value is 0, the packet contains a sound specified by Identifier.
        public let sound_id:VariableInteger
        /// Only present if `sound_id` is 0
        public let sound_name:Namespace?
        /// Only present if `sound_id` is 0
        public let has_fixed_range:Bool?
        /// The fixed range of the sound. Only present if `has_fixed_range` is true and `sound_id` is 0.
        public let range:Float?
        /// The category that this sound will be played from.
        public let sound_category:SoundCategoryMojang
        /// Effect X multiplied by 8 (fixed-point number with only 3 bits dedicated to the fractional part).
        public let effect_position_x:Int
        /// Effect X multiplied by 8 (fixed-point number with only 3 bits dedicated to the fractional part).
        public let effect_position_y:Int
        /// Effect X multiplied by 8 (fixed-point number with only 3 bits dedicated to the fractional part).
        public let effect_position_z:Int
        /// 1.0 is 100%, capped between 0.0 and 1.0 by Notchian clients.
        public let volume:Float
        /// Float between 0.5 and 2.0 by Notchian clients.
        public let pitch:Float
        /// Seed used to pick sound variant.
        public let seed:Int
    }
}
