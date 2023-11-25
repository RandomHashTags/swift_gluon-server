//
//  Packet.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol Packet : Codable, PacketEncodable {
    associatedtype IDValue : Codable
    associatedtype Category : PacketCategory
    associatedtype PacketType : GeneralPacket
    
    static func parse(_ packet: PacketType) throws -> Self
    
    var platform : PacketPlatform { get }
    var category : Category { get }
    
    func to_general() throws -> PacketType
}
public extension Packet {
    static func parse(_ packet: PacketType) throws -> Self {
        throw GeneralPacketError.not_implemented(packet_type: Self.self)
    }
    
    func to_general() throws -> PacketType {
        return try PacketType(bytes: packet_bytes())
    }
}
