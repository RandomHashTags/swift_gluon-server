//
//  CPMLSetCompression.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Login {
    /// Enables compression. If compression is enabled, all following packets are encoded in the compressed packet format. Negative values will disable compression, meaning the packet format should remain in the uncompressed packet format. However, this packet is entirely optional, and if not sent, compression will also not be enabled (the notchian server does not send the packet when compression is disabled).
    struct SetCompression : ClientPacketMojangProtocol {
        let threshold:Int
    }
}
