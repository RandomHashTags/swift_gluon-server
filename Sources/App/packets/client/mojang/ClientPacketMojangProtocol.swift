//
//  ClientPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ClientPacketMojangProtocol : ClientPacket, PacketMojang {
}

// MARK: ClientPacketMojangLoginProtocol
public protocol ClientPacketMojangLoginProtocol : ClientPacketMojangProtocol {
}
public extension ClientPacketMojangLoginProtocol {
    var category : Category {
        return Category.client_login
    }
}

// MARK: ClientPacketMojangPlayProtocol
public protocol ClientPacketMojangPlayProtocol : ClientPacketMojangProtocol {
}
public extension ClientPacketMojangPlayProtocol {
    var category : Category {
        return Category.client_play
    }
}
