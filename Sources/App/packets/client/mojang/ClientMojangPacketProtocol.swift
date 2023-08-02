//
//  ClientMojangPacketProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ClientMojangPacketProtocol : ClientPacket {
}

public extension ClientMojangPacketProtocol {
    var platform : ClientPacketType {
        return ClientPacketType.mojang
    }
}
