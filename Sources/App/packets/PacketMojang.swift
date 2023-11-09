//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang, PacketType == GeneralPacketMojang {
    
    associatedtype GameplayID : PacketGameplayID
    
    static var packet_gameplay_id : GameplayID.Type { get }
    
    static var id : GameplayID { get }
    
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
    
    // TODO: support compression
    func as_client_response() throws -> Data {
        let packet_id_bytes:[UInt8] = try VariableInteger(value: Int32(Self.id.rawValue)).packet_bytes()
        let packet_bytes:[UInt8] = try packet_bytes()
        
        let length:Int = packet_id_bytes.count + packet_bytes.count
        var bytes:[UInt8] = try VariableInteger(value: Int32(length)).packet_bytes()
        bytes.append(contentsOf: packet_id_bytes)
        bytes.append(contentsOf: packet_bytes)
        
        print("PacketMojang;as_client_response;packet_id_bytes.count=\(packet_id_bytes.count);packet_bytes.count=\(packet_bytes.count);length=\(length)")
        return Data(bytes)
    }
}
