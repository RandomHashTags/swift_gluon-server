//
//  PacketMojangJava.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

protocol PacketMojangJava : Packet where IDValue == UInt, Category == PacketCategoryMojangJava, PacketType == GeneralPacketMojang {
    
    associatedtype GameplayID : PacketGameplayID
    
    static func server_received(_ client: ClientMojangJava) throws
    static var packetGameplayID : GameplayID.Type { get }
    
    static var id : GameplayID { get }
    
    func encoded_values() throws -> [(any PacketEncodableMojangJava)?]
}

extension PacketMojangJava {
    static func server_received(_ client: ClientMojangJava) throws {
        ServerMojang.instance.logger.warning("missing `server_received` static function implementation for PacketMojangJava `\(Self.self)` with id \"\(id)\"")
    }
    
    var platform : PacketPlatform {
        return PacketPlatform.mojang_java
    }
    
    func packet_bytes() throws -> [UInt8] {
        let encodable_bytes:[any PacketEncodableMojangJava] = try encoded_values().compactMap({ $0 })
        return try encodable_bytes.flatMap({ try $0.packet_bytes() })
    }
    
    // TODO: support compression
    func as_client_response() throws -> Data {
        let packet_id_bytes:[UInt8] = try VariableIntegerJava(value: Int32(Self.id.rawValue)).packet_bytes()
        let data:[UInt8] = try packet_bytes()
        
        let length:Int = packet_id_bytes.count + data.count
        var bytes:[UInt8] = try VariableIntegerJava(value: Int32(length)).packet_bytes()
        bytes.append(contentsOf: packet_id_bytes)
        bytes.append(contentsOf: data)
        
        print("PacketMojangJava;as_client_response;id=\(Self.id);packet_id_bytes.count=\(packet_id_bytes.count);data.count=\(data.count);length=\(length)")
        return Data(bytes)
    }
}
