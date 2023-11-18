//
//  PlayerConnection.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation
import Socket

public protocol PlayerConnection : PacketReceiver {
    var platform : PacketPlatform { get }
    
    var socket : Socket { get set }
    var ping : UInt16 { get }
    
    func close(reason: String)
}
