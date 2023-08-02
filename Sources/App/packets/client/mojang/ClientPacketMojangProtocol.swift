//
//  ClientPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ClientPacketMojangProtocol : ClientPacket {
}

public extension ClientPacketMojangProtocol {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
}
