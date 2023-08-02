//
//  ServerPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ServerPacketMojangProtocol : ServerPacket {
}

public extension ServerPacketMojangProtocol {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
}
