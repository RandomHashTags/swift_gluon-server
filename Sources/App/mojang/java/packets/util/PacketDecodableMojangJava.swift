//
//  PacketDecodableMojangJava.swift
//  
//
//  Created by Evan Anderson on 8/7/23.
//

import Foundation

public protocol PacketDecodableMojangJava {
    static func decode(from packet: GeneralPacketMojang) throws -> Self
    func packet_bytes() throws -> [UInt8]
}
