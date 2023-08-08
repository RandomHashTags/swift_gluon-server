//
//  CPMLSetCompression.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// Enables compression. If compression is enabled, all following packets are encoded in the compressed packet format. Negative values will disable compression, meaning the packet format should remain in the uncompressed packet format. However, this packet is entirely optional, and if not sent, compression will also not be enabled (the notchian server does not send the packet when compression is disabled).
    struct SetCompression : ClientPacketMojangLoginProtocol {
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let threshold:VariableInteger = try packet.read_var_int()
            return Self(threshold: threshold)
        }
        
        /// Maximum size of a packet before it is compressed.
        public let threshold:VariableInteger
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            return [threshold]
        }
    }
}
