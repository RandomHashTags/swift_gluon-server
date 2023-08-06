//
//  Packet.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol Packet : Hashable, Codable {
    associatedtype IDValue : Codable
    associatedtype Category : PacketCategory
    associatedtype PacketType : GeneralPacket
    
    static func parse(_ packet: inout PacketType) throws -> Self
    
    var platform : PacketPlatform { get }
    var category : Category { get }
    
    //func to_sendable(category: Category, id: IDValue) -> (any SendablePacket)?
}
public extension Packet {
    static func parse(_ packet: inout PacketType) throws -> Self {
        throw GeneralPacketError.not_implemented(packet_type: Self.self)
    }
}

/*
public protocol SendablePacket : Hashable, Codable {
    associatedtype IDValue : Codable
    associatedtype Category : PacketCategory
    
    var platform : PacketPlatform { get }
    var category : Category { get }
    
    func uncompressed() -> any UncompressedPacket
    func compressed() -> any CompressedPacket
}

// MARK: UncompressedPacket
public protocol UncompressedPacket : SendablePacket {
    /// Length of `packet_id` + `data`
    var length : Int { get }
    var packet_id : IDValue { get }
    /// Depends on the connection state and `packet_id`.
    var data : Data { get }
}


// MARK: CompressedPacket
public protocol CompressedPacket : SendablePacket {
    /// Length of `data_length` + Compressed length of (`packet_id` + `data`)
    var packet_length : Int { get }
    /// Length of uncompressed (`packet_id` + `data`) or 0
    var data_length : Int { get }
    /// zlib compressed `packet_id`
    var packet_id : IDValue { get }
    /// zlib compressed packet data.
    var data : Data { get }
}

struct SendablePacketMojang : SendablePacket {
}
struct UncompressedPacketMojang : UncompressedPacket, PacketMojang {
    typealias IDValue = UInt
    typealias Category = PacketCategoryMojang
    
    var category:PacketCategoryMojang
    let length:Int
    let packet_id:IDValue
    let data:Data
}
*/
