//
//  SPMPClickContainerButton.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Play {
    struct ClickContainerButton : ServerPacketMojangJavaPlayProtocol {
        public static let id:ServerPacket.Mojang.Java.Play = ServerPacket.Mojang.Java.Play.click_container_button
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let windowID:Int8 = try packet.readByte()
            let button_id:Int8 = try packet.readByte()
            return Self(windowID: windowID, button_id: button_id)
        }
        
        /// The ID of the window sent by [Open Screen](https://wiki.vg/Protocol#Open_Screen ).
        public let windowID:Int8
        /// Meaning depends on window type.
        public let button_id:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID, button_id]
        }
    }
}
