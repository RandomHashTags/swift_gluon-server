//
//  PlayerConnection.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public protocol PlayerConnection : AnyObject, PacketReceiver {
    var platform : PacketPlatform { get }
    
    var player_uuid : UUID { get }
    var socket : URLSessionWebSocketTask { get set }
    var ping : UInt16 { get }
    
    func update_ping()
    
    func close(reason: Data?)
}
