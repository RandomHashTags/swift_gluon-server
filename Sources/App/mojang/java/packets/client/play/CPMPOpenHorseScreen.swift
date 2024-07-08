//
//  CPMPOpenHorseScreen.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This packet is used exclusively for opening the horse GUI. Open Screen is used for all other GUIs. The client will not open the inventory if the Entity ID does not point to an horse-like animal.
    struct OpenHorseScreen : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.open_horse_screen
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let windowID:UInt8 = try packet.readUnsignedByte()
            let slotCount:VariableIntegerJava = try packet.readVarInt()
            let entityID:Int32 = try packet.readInt()
            return Self(windowID: windowID, slotCount: slotCount, entityID: entityID)
        }
        
        public let windowID:UInt8
        public let slotCount:VariableIntegerJava
        public let entityID:Int32
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID, slotCount, entityID]
        }
    }
}
