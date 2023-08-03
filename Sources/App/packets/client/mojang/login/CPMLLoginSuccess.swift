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
    struct LoginSuccess : ClientPacketMojangProtocol {
        let uuid:UUID
        let username:String
        /// Number of elements in `properties`.
        let number_of_properties:Int
        let properties:[LoginSuccess.Property]
        
        struct Property : Hashable, Codable {
            let name:String
            let value:String
            let is_signed:Bool
            /// Only if `is_signed` is `true`.
            let signature:String?
        }
    }
}
