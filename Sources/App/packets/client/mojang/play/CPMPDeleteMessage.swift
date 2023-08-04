//
//  CPMPDeleteMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Removes a message from the client's chat. This only works for messages with signatures, system messages cannot be deleted with this packet.
    struct DeleteMessage : ClientPacketMojangPlayProtocol {
        /// Length of Signature.
        public let signature_length:Int
        /// Bytes of the signature.
        public let signature:Data
    }
}
