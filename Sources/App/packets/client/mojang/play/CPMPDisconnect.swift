//
//  CPMPDisconnect.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Sent by the server before it disconnects a client. The client assumes that the server has already closed the connection by the time the packet arrives.
    struct Disconnect : ClientPacketMojangProtocol {
        /// Displayed to the client when the connection terminates.
        let reason:ChatPacketMojang
    }
}
