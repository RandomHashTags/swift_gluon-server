//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang, PacketType == GeneralPacketMojang {
    func encoded_values() throws -> [(any PacketEncodableMojang)?]
}

public extension PacketMojang {
    var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
    
    func packet_bytes() throws -> [UInt8] {
        var bytes:[UInt8] = [UInt8]()
        for codable in try encoded_values().compactMap({ $0 }) {
            bytes.append(contentsOf: try codable.packet_bytes())
        }
        return bytes
    }
}
