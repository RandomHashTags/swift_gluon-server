//
//  ServerPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ServerPacketMojangProtocol : ServerPacket, PacketMojang where IDValue == UInt, Category == PacketCategoryMojang {
}

// MARK: ServerPacketMojangHandshakingProtocol
public protocol ServerPacketMojangHandshakingProtocol : ServerPacketMojangProtocol {
}
public extension ServerPacketMojangHandshakingProtocol {
    var category : Category {
        return Category.server_handshaking
    }
}

// MARK: ServerPacketMojangStatusProtocol
public protocol ServerPacketMojangStatusProtocol : ServerPacketMojangProtocol {
}
public extension ServerPacketMojangStatusProtocol {
    var category : Category {
        return Category.server_status
    }
}
