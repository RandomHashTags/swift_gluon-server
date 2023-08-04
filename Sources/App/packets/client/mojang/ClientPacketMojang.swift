//
//  ClientPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public enum ClientPacketMojang {
    /// There are no clientbound packets in the Handshaking state, since the protocol immediately switches to a different state after the client sends the first packet.
    public enum Handshaking {
    }
    public enum Status {
    }
    public enum Login {
    }
    public enum Play {
    }
}
