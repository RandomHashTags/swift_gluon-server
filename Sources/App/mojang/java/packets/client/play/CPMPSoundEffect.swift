//
//  CPMPSoundEffect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Plays a sound effect at the given location, either by hardcoded ID or Identifier. Sound IDs and names can be found at https://pokechu22.github.io/Burger/1.20.1.html#sounds .
    /// - Warning: Numeric sound effect IDs are liable to change between versions
    struct SoundEffect : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.sound_effect
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let soundID:VariableIntegerJava = try packet.readVarInt()
            var soundName:Namespace? = nil
            var hasFixedRange:Bool? = nil
            var range:Float? = nil
            if soundID.value == 0 {
                soundName = try packet.readIdentifier()
                hasFixedRange = try packet.readBool()
                if let hasFixedRange:Bool = hasFixedRange, hasFixedRange {
                    range = try packet.readFloat()
                }
            }
            let soundCategory:SoundCategory = try packet.readEnum()
            let effect_position_x:Int32 = try packet.readInt()
            let effect_position_y:Int32 = try packet.readInt()
            let effect_position_z:Int32 = try packet.readInt()
            let volume:Float = try packet.readFloat()
            let pitch:Float = try packet.readFloat()
            let seed:Int64 = try packet.readLong()
            return Self(soundID: soundID, soundName: soundName, hasFixedRange: hasFixedRange, range: range, soundCategory: soundCategory, effect_position_x: effect_position_x, effect_position_y: effect_position_y, effect_position_z: effect_position_z, volume: volume, pitch: pitch, seed: seed)
        }
        
        /// Represents the `Sound ID + 1`. If the value is 0, the packet contains a sound specified by Identifier.
        public let soundID:VariableIntegerJava
        /// Only present if `soundID` is 0
        public let soundName:Namespace?
        /// Only present if `soundID` is 0
        public let hasFixedRange:Bool?
        /// The fixed range of the sound. Only present if `hasFixedRange` is true and `soundID` is 0.
        public let range:Float?
        /// The category that this sound will be played from.
        public let soundCategory:SoundCategory
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
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [soundID]
            if soundID.value == 0 {
                array.append(soundName)
                array.append(hasFixedRange)
                
                if let hasFixedRange:Bool = hasFixedRange, hasFixedRange {
                    array.append(range)
                }
            }
            let secondary:[(any PacketEncodableMojangJava)?] = [
                soundCategory,
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
