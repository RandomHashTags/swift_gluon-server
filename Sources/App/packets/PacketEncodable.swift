//
//  PacketEncodable.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public protocol PacketEncodable {
    var packet_bytes : [UInt8] { get }
}
