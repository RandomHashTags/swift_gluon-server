//
//  SPMSStatusRequest.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ServerPacketMojang.Status {
    /// The status can only be requested once immediately after the handshake, before any ping. The server won't respond otherwise.
    struct StatusRequest : ServerPacketMojangStatusProtocol {
    }
}
