//
//  CPMPCloseContainer.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// This packet is sent from the server to the client when a window is forcibly closed, such as when a chest is destroyed while it's open. The notchian client disregards the provided window ID and closes any active window.
    struct CloseContainer : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.close_container
        
        /// This is the ID of the window that was closed. 0 for inventory.
        let windowID:UInt8
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            return [windowID]
        }
    }
}
