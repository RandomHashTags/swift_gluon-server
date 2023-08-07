//
//  CPMPEntitySoundEffect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Plays a sound effect from an entity, either by hardcoded ID or Identifier. Sound IDs and names can be found at https://pokechu22.github.io/Burger/1.20.1.html#sounds .
    /// - Warning: Numeric sound effect IDs are liable to change between versions
    struct EntitySoundEffect : ClientPacketMojangPlayProtocol {
        public static func parse(_ packet: inout GeneralPacketMojang) throws -> Self {
            let sound_id:Int = try packet.read_var_int()
            let sound_name:String?
            let has_fixed_range:Bool?
            let range:Float?
            if sound_id == 0 {
                sound_name = try packet.read_string()
                has_fixed_range = try packet.read_bool()
                if let has_fixed_range:Bool = has_fixed_range, has_fixed_range {
                    range = try packet.read_float()
                } else {
                    range = nil
                }
            } else {
                sound_name = nil
                has_fixed_range = nil
                range = nil
            }
            let sound_category:SoundCategoryMojang = try packet.read_enum()
            let entity_id:Int = try packet.read_var_int()
            let volume:Float = try packet.read_float()
            let pitch:Float = try packet.read_float()
            let seed:Int = try packet.read_long()
            return Self(sound_id: sound_id, sound_name: sound_name, has_fixed_range: has_fixed_range, range: range, sound_category: sound_category, entity_id: entity_id, volume: volume, pitch: pitch, seed: seed)
        }
        
        /// Represents the `sound_id + 1`. If the value is 0, the packet contains a sound specified by Identifier.
        public let sound_id:Int
        /// Only present if `sound_id` is 0.
        public let sound_name:String?
        /// Only present if `sound_id` is 0.
        public let has_fixed_range:Bool?
        /// The fixed range of the sound. Only present if previous boolean is true and `sound_id` is 0.
        public let range:Float?
        /// The category that this sound will be played from.
        public let sound_category:SoundCategoryMojang
        public let entity_id:Int
        /// 1.0 is 100%, capped between 0.0 and 1.0 by Notchian clients.
        public let volume:Float
        /// Float between 0.5 and 2.0 by Notchian clients.
        public let pitch:Float
        /// Seed used to pick sound variant.
        public let seed:Int
        
        public var encoded_values : [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [sound_id]
            if sound_id == 0 {
                array.append(sound_name)
                array.append(has_fixed_range)
                if let has_fixed_range:Bool = has_fixed_range, has_fixed_range {
                    array.append(range)
                }
            }
            let final_array:[PacketEncodableMojang?] = [
                sound_category,
                entity_id,
                volume,
                pitch,
                seed
            ]
            array.append(contentsOf: final_array)
            return array
        }
    }
}
