//
//  ClientPacket.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol ClientPacket : Hashable, Codable {
    var platform : ClientPacketType { get }
}
