//
//  PacketEncodable.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketEncodable {
    func packet_bytes() throws -> [UInt8]
    
    func unwrap_optional<T, R>(_ value: R?, key_path: KeyPath<Self, T>, precondition: String) throws -> R
}

public extension PacketEncodable {
    func unwrap_optional<T, R>(_ value: R?, key_path: KeyPath<Self, T>, precondition: String) throws -> R {
        guard let value:R = value else {
            throw GeneralPacketError.optional_value_cannot_be_optional(type: Self.self, value: "\(key_path)", precondition: precondition)
        }
        return value
    }
}
