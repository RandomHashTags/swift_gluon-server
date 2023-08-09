//
//  Namespace.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public struct Namespace : Hashable, Codable, LosslessStringConvertible, PacketEncodableMojang, PacketDecodableMojang { // TODO: fix (PacketEncodableMojang)
    public static func decode(from packet: GeneralPacketMojang) throws -> Self {
        return try packet.read_identifier()
    }
    
    public let identifier:Substring
    public let value:Substring
    
    public init(identifier: Substring, value: Substring) {
        self.identifier = identifier
        self.value = value
    }
    
    public init?(_ description: String) {
        let values:[Substring] = description.split(separator: ":")
        guard values.count == 2 else { return nil }
        identifier = values[0]
        value = values[1]
    }
    
    public var description : String {
        return identifier + ":" + value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container:SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(description)
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string:String = try container.decode(String.self)
        guard let namespace:Namespace = Namespace(string) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "invalid string: \(string)"))
        }
        self = namespace
    }
    
    public func packet_bytes() throws -> [UInt8] {
        return try description.packet_bytes()
    }
}
