//
//  GeneralPacket.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

public protocol GeneralPacket : Hashable {
    init(bytes: [UInt8]) throws
}
