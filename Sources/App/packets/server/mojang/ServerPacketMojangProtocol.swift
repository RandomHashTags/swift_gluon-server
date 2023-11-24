//
//  ServerPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ServerPacketMojangProtocol : ServerPacket, PacketMojang {
}

// MARK: ServerPacketMojangHandshakingProtocol
public protocol ServerPacketMojangHandshakingProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangHandshaking {
}
public extension ServerPacketMojangHandshakingProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangHandshaking.self
        }
    }
}
public extension ServerPacketMojangHandshakingProtocol {
    var category : Category {
        return Category.server_handshaking
    }
}

// MARK: ServerPacketMojangPlayProtocol
public protocol ServerPacketMojangLoginProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangLogin {
}
public extension ServerPacketMojangLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangLogin.self
        }
    }
}
public extension ServerPacketMojangLoginProtocol {
    var category : Category {
        return Category.server_login
    }
}

// MARK: ServerPacketMojangConfigurationProtocol
public protocol ServerPacketMojangConfigurationProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangConfiguration {
}
public extension ServerPacketMojangConfigurationProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangConfiguration.self
        }
    }
}
public extension ServerPacketMojangConfigurationProtocol {
    var category : Category {
        return Category.server_configuration
    }
}

// MARK: ServerPacketMojangPlayProtocol
public protocol ServerPacketMojangPlayProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangPlay {
}
public extension ServerPacketMojangPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangPlay.self
        }
    }
}
public extension ServerPacketMojangPlayProtocol {
    var category : Category {
        return Category.server_play
    }
}

// MARK: ServerPacketMojangStatusProtocol
public protocol ServerPacketMojangStatusProtocol : ServerPacketMojangProtocol where GameplayID == ServerPacketMojangStatus {
}
public extension ServerPacketMojangStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ServerPacketMojangStatus.self
        }
    }
}
public extension ServerPacketMojangStatusProtocol {
    var category : Category {
        return Category.server_status
    }
}
