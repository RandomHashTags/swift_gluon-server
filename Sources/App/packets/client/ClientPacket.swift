//
//  ClientPacket.swift
//
//
//  Created by Evan Anderson on 11/25/23.
//

import Foundation

public enum ClientPacket {
    
    public enum Mojang {
        public enum Bedrock {
        }
        public enum Java { // https://wiki.vg/Protocol
            /// There are no clientbound packets in the Handshaking state, since the protocol immediately switches to a different state after the client sends the first packet.
            public enum Handshaking {
            }
        }
    }
    
    public enum Gluon {
    }
    
}
