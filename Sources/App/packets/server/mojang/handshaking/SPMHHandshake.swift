//
//  SPMHHandshake.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Handshaking {
    /// This causes the server to switch into the target state.
    struct Handshake : ServerPacketMojangHandshakingProtocol {
        /// See https://wiki.vg/Protocol_version_numbers .
        public let protocol_version:Int
        /// Hostname or IP, e.g. localhost or 127.0.0.1, that was used to connect. The Notchian server does not use this information.
        /// > Note: SRV records are a simple redirect, e.g. if \_minecraft.\_tcp.example.com points to mc.example.org, users connecting to example.com will provide example.org as server address in addition to connecting to it.
        public let server_address:String
        /// Default is 25565. The Notchian server does not use this information.
        public let server_port:Int
        public let next_state:ServerPacketMojang.Status
    }
}
