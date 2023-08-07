//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang, PacketType == GeneralPacketMojang {
    var encoded_values : [PacketEncodableMojang?] { get }
}

public extension PacketMojang {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
    
    var packet_bytes : [UInt8] {
        var bytes:[UInt8] = [UInt8]()
        for codable in encoded_values.compactMap({ $0 }) {
            bytes.append(contentsOf: codable.packet_bytes)
        }
        return bytes
    }
}
