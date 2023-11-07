//
//  SPMPClickContainerButton.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    struct ClickContainerButton : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.click_container_button
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let window_id:Int8 = try packet.read_byte()
            let button_id:Int8 = try packet.read_byte()
            return Self(window_id: window_id, button_id: button_id)
        }
        
        /// The ID of the window sent by [Open Screen](https://wiki.vg/Protocol#Open_Screen ).
        public let window_id:Int8
        /// Meaning depends on window type.
        public let button_id:Int8
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [window_id, button_id]
        }
    }
}
