//
//  PacketReceiver.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public protocol PacketReceiver {
    func send_packet<T : Packet>(_ packet: T) throws
}
