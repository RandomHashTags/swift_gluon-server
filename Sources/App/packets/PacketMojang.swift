//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang {
}

public extension PacketMojang {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
    
    /*func to_sendable(category: Category, id: IDValue) -> (any SendablePacket)? {
        switch category {
        case .client_play:
            return ClientPacketMojangPlay.init(rawValue: id)
        default:
            return nil
        }
    }*/
}
