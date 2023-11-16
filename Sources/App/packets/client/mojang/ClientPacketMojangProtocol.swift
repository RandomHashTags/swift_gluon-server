//
//  ClientPacketMojangProtocol.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public protocol ClientPacketMojangProtocol : ClientPacket, PacketMojang {
}

// MARK: ClientPacketMojangStatusProtocol
public protocol ClientPacketMojangStatusProtocol : ClientPacketMojangProtocol where GameplayID == ClientPacketMojangStatus {
}
public extension ClientPacketMojangStatusProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacketMojangStatus.self
        }
    }
}
public extension ClientPacketMojangStatusProtocol {
    var category : Category {
        return Category.client_handshaking
    }
}

// MARK: ClientPacketMojangLoginProtocol
public protocol ClientPacketMojangLoginProtocol : ClientPacketMojangProtocol where GameplayID == ClientPacketMojangLogin {
}
public extension ClientPacketMojangLoginProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacketMojangLogin.self
        }
    }
}
public extension ClientPacketMojangLoginProtocol {
    var category : Category {
        return Category.client_login
    }
}

// MARK: ClientPacketMojangLoginProtocol
public protocol ClientPacketMojangConfigurationProtocol : ClientPacketMojangProtocol where GameplayID == ClientPacketMojangConfiguration {
}
public extension ClientPacketMojangConfigurationProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacketMojangConfiguration.self
        }
    }
}
public extension ClientPacketMojangConfigurationProtocol {
    var category : Category {
        return Category.client_configuration
    }
}

// MARK: ClientPacketMojangPlayProtocol
public protocol ClientPacketMojangPlayProtocol : ClientPacketMojangProtocol where GameplayID == ClientPacketMojangPlay {
}
public extension ClientPacketMojangPlayProtocol {
    static var packet_gameplay_id : GameplayID.Type {
        get {
            return ClientPacketMojangPlay.self
        }
    }
}
public extension ClientPacketMojangPlayProtocol {
    var category : Category {
        return Category.client_play
    }
}
