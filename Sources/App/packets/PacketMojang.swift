//
//  PacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public protocol PacketMojang : Packet where IDValue == UInt, Category == PacketCategoryMojang, PacketType == GeneralPacketMojang {
    
    associatedtype GameplayID : PacketGameplayID
    
    static func server_received(_ client: ServerMojangClient) throws
    static var packet_gameplay_id : GameplayID.Type { get }
    
    static var id : GameplayID { get }
    
    func encoded_values() throws -> [(any PacketEncodableMojang)?]
}

public extension PacketMojang {
    static func server_received(_ client: ServerMojangClient) throws {
        print("missing `server_received` static function implementation for PacketMojang `\(Self.self)` with id \"\(id)\"")
    }
    
    var platform : PacketPlatform {
        return PacketPlatform.mojang_java
    }
    
    func packet_bytes() throws -> [UInt8] {
        let encodable_bytes:[any PacketEncodableMojang] = try encoded_values().compactMap({ $0 })
        return try encodable_bytes.flatMap({ try $0.packet_bytes() })
    }
    
    // TODO: support compression
    func as_client_response() throws -> Data {
        let packet_id_bytes:[UInt8] = try VariableInteger(value: Int32(Self.id.rawValue)).packet_bytes()
        let data:[UInt8] = try packet_bytes()
        
        let length:Int = packet_id_bytes.count + data.count
        var bytes:[UInt8] = try VariableInteger(value: Int32(length)).packet_bytes()
        bytes.append(contentsOf: packet_id_bytes)
        bytes.append(contentsOf: data)
        
        print("PacketMojang;as_client_response;packet_id_bytes.count=\(packet_id_bytes.count);data.count=\(data.count);length=\(length)")
        return Data(bytes)
    }
}
