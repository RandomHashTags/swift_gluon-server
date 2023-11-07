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
        let encodable_bytes:[any PacketEncodableMojang] = try encoded_values().compactMap({ $0 })
        return try encodable_bytes.flatMap({ try $0.packet_bytes() })
    }
}
