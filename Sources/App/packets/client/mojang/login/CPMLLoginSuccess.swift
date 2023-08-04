//
//  CPMLLoginSuccess.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// This packet switches the connection state to play.
    /// - Warning: The (notchian) server might take a bit to fully transition to the Play state, so it's recommended to wait for the Login (play) packet from the server.
    /// - Warning: The notchian client doesn't send any packets until the Login (play) packet.
    struct LoginSuccess : ClientPacketMojangLoginProtocol {
        public let uuid:UUID
        public let username:String
        /// Number of elements in `properties`.
        public let number_of_properties:Int
        public let properties:[LoginSuccess.Property]
        
        public struct Property : Hashable, Codable {
            public let name:String
            public let value:String
            public let is_signed:Bool
            /// Only if `is_signed` is `true`.
            public let signature:String?
        }
    }
}
