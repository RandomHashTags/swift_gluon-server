//
//  SPMPPluginMessage.swift
//  
//
//  Created by Evan Anderson on 8/9/23.
//

import Foundation

public extension ServerPacketMojang.Play {
    /// Mods and plugins can use this to send their data. Minecraft itself uses some [plugin channels](https://wiki.vg/Plugin_channel ). These internal channels are in the `minecraft` namespace.
    ///
    /// [More documentation on this](https://dinnerbone.com/blog/2012/01/13/minecraft-plugin-channels-messaging/)
    ///
    /// Note that the length of Data is known only from the packet length, since the packet has no length field of any kind.
    ///
    /// In Notchian server, the maximum data length is 32767 bytes.
    /// > Note: [Main article](https://wiki.vg/Plugin_channels)
    struct PluginMessage : ServerPacketMojangPlayProtocol {
        public static let id:ServerPacketMojangPlay = ServerPacketMojangPlay.plugin_message
        
        /// Name of the [plugin channel](https://wiki.vg/Plugin_channel) used to send the data.
        public let channel:Namespace
        /// Any data, depending on the channel. `minecraft:` channels are documented [here](https://wiki.vg/Plugin_channel ). The length of this array must be inferred from the packet length.
        public let data:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            var array:[any PacketEncodableMojang] = [channel]
            array.append(contentsOf: data)
            return array
        }
    }
}
