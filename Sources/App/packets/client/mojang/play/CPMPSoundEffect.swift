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
        public static let id:ClientPacketMojangPlay = ClientPacketMojangPlay.sound_effect
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let sound_id:VariableInteger = try packet.read_var_int()
            var sound_name:Namespace? = nil
            var has_fixed_range:Bool? = nil
            var range:Float? = nil
            if sound_id.value == 0 {
                sound_name = try packet.read_identifier()
                has_fixed_range = try packet.read_bool()
                if let has_fixed_range:Bool = has_fixed_range, has_fixed_range {
                    range = try packet.read_float()
                }
            }
            let sound_category:SoundCategoryMojang = try packet.read_enum()
            let effect_position_x:Int32 = try packet.read_int()
            let effect_position_y:Int32 = try packet.read_int()
            let effect_position_z:Int32 = try packet.read_int()
            let volume:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            let seed:Int64 = try packet.read_long()
            return Self(sound_id: sound_id, sound_name: sound_name, has_fixed_range: has_fixed_range, range: range, sound_category: sound_category, effect_position_x: effect_position_x, effect_position_y: effect_position_y, effect_position_z: effect_position_z, volume: volume, pitch: pitch, seed: seed)
        }
        
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
        public let effect_position_x:Int32
        /// Effect X multiplied by 8 (fixed-point number with only 3 bits dedicated to the fractional part).
        public let effect_position_y:Int32
        /// Effect X multiplied by 8 (fixed-point number with only 3 bits dedicated to the fractional part).
        public let effect_position_z:Int32
        /// 1.0 is 100%, capped between 0.0 and 1.0 by Notchian clients.
        public let volume:Float
        /// Float between 0.5 and 2.0 by Notchian clients.
        public let pitch:Float
        /// Seed used to pick sound variant.
        public let seed:Int64
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[(any PacketEncodableMojang)?] = [sound_id]
            if sound_id.value == 0 {
                array.append(sound_name)
                array.append(has_fixed_range)
                
                if let has_fixed_range:Bool = has_fixed_range, has_fixed_range {
                    array.append(range)
                }
            }
            let secondary:[(any PacketEncodableMojang)?] = [
                sound_category,
                effect_position_x,
                effect_position_y,
                effect_position_z,
                volume,
                pitch,
                seed
            ]
            array.append(contentsOf: secondary)
            return array
        }
    }
}
