//
//  CPMPCloseContainer.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// This packet is sent from the server to the client when a window is forcibly closed, such as when a chest is destroyed while it's open. The notchian client disregards the provided window ID and closes any active window.
    struct CloseContainer : ClientPacketMojangPlayProtocol {
        /// This is the ID of the window that was closed. 0 for inventory.
        let window_id:UInt8
    }
}
