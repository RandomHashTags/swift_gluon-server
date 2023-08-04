//
//  PacketCategoryMojang.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public enum PacketCategoryMojang : PacketCategory {
    case client_handshaking
    case client_login
    case client_play
    case client_status
    
    case server_handshaking
    case server_login
    case server_play
    case server_status
    
    /// the associated packet is meant to be a placeholder for something
    case middleware
}
