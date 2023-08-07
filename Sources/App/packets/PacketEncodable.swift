//
//  PacketEncodable.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketEncodable {
    func packet_bytes() throws -> [UInt8]
}
