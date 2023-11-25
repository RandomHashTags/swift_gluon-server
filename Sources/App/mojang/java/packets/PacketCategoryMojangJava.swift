//
//  PacketCategoryMojangJava.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public enum PacketCategoryMojangJava : PacketCategory {
    case client_handshaking
    case client_login
    case client_configuration
    case client_play
    case client_status
    
    case server_handshaking
    case server_login
    case server_configuration
    case server_play
    case server_status
    
    /// the associated packet is meant to be a placeholder for something
    case middleware
}
