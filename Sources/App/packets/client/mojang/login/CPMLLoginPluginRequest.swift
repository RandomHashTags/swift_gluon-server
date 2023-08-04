//
//  CPMLLoginPluginRequest.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// Used to implement a custom handshaking flow together with Login Plugin Response.
    ///
    /// Unlike plugin messages in "play" mode, these messages follow a lock-step request/response scheme, where the client is expected to respond to a request indicating whether it understood. The notchian client always responds that it hasn't understood, and sends an empty payload.
    ///
    /// In Notchian client, the maximum data length is 1048576 bytes.
    struct LoginPluginRequest : ClientPacketMojangLoginProtocol {
        public let message_id:Int
        public let channel:String // TODO: fix (make `Identifier`)
        public let data:Data
    }
}
