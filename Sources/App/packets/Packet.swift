//
//  Packet.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol Packet : Hashable, Codable {
    var platform : PacketPlatform { get }
}
