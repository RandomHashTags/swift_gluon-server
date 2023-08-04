//
//  CPMSStatusResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct StatusResponse : ClientPacketMojangStatusProtocol {
        /// See https://wiki.vg/Server_List_Ping#Response ; as with all strings this is prefixed by its length as a VarInt.
        public let json_response:String
    }
}
