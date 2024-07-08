//
//  CPMPEntitySoundEffect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Plays a sound effect from an entity, either by hardcoded ID or Identifier. Sound IDs and names can be found at https://pokechu22.github.io/Burger/1.20.1.html#sounds .
    /// - Warning: Numeric sound effect IDs are liable to change between versions
    struct EntitySoundEffect : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.entity_sound_effect
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let soundID:VariableIntegerJava = try packet.readVarInt()
            let soundName:String?
            let hasFixedRange:Bool?
            let range:Float?
            if soundID.value == 0 {
                soundName = try packet.readString()
                hasFixedRange = try packet.readBool()
                if let hasFixedRange:Bool = hasFixedRange, hasFixedRange {
                    range = try packet.readFloat()
                } else {
                    range = nil
                }
            } else {
                soundName = nil
                hasFixedRange = nil
                range = nil
            }
            let soundCategory:SoundCategory = try packet.readEnum()
            let entityID:VariableIntegerJava = try packet.readVarInt()
            let volume:Float = try packet.readFloat()
            let pitch:Float = try packet.readFloat()
            let seed:Int64 = try packet.readLong()
            return Self(soundID: soundID, soundName: soundName, hasFixedRange: hasFixedRange, range: range, soundCategory: soundCategory, entityID: entityID, volume: volume, pitch: pitch, seed: seed)
        }
        
        /// Represents the `soundID + 1`. If the value is 0, the packet contains a sound specified by Identifier.
        public let soundID:VariableIntegerJava
        /// Only present if `soundID` is 0.
        public let soundName:String?
        /// Only present if `soundID` is 0.
        public let hasFixedRange:Bool?
        /// The fixed range of the sound. Only present if previous boolean is true and `soundID` is 0.
        public let range:Float?
        /// The category that this sound will be played from.
        public let soundCategory:SoundCategory
        public let entityID:VariableIntegerJava
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
            let final_array:[(any PacketEncodableMojangJava)?] = [
                soundCategory,
                entityID,
                volume,
                pitch,
                seed
            ]
            array.append(contentsOf: final_array)
            return array
        }
    }
}
