//
//  CPMJCPluginMessage.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

public extension ClientPacket.Mojang.Java.Configuration {
    /// Mods and plugins can use this to send their data. Minecraft itself uses several [plugin channels](https://wiki.vg/Plugin_channel ). These internal channels are in the `minecraft` namespace.
    /// More information on how it works on [Dinnerbone's blog](https://dinnerbone.com/blog/2012/01/13/minecraft-plugin-channels-messaging/ ). More documentation about internal and popular registered channels are [here](https://wiki.vg/Plugin_channel ).
    ///
    /// - Note: In Notchian client, the maximum data length is 1048576 bytes.
    struct PluginMessage : ClientPacketMojangJavaConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.plugin_message
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let channel:Namespace = try packet.read_identifier()
            let data:[UInt8] = try packet.read_remaining_byte_array()
            return Self(channel: channel, data: data)
        }
        
        /// Name of the [plugin channel](https://wiki.vg/Plugin_channel) used to send the data.
        public let channel:Namespace
        /// Any data. The length of this array must be inferred from the packet length.
        public let data:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var values:[any PacketEncodableMojangJava] = [channel]
            values.append(contentsOf: data)
            return values
        }
    }
}
