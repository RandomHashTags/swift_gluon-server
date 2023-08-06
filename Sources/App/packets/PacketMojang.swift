//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang, PacketType == GeneralPacketMojang {
}

public extension PacketMojang {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
    
    func get_encoded_bytes() -> [UInt8] {
        var bytes:[UInt8] = [UInt8]()
        for codable in get_encoded_values().compactMap({ $0 }) {
            bytes.append(contentsOf: codable.packet_bytes_mojang)
        }
        return bytes
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
