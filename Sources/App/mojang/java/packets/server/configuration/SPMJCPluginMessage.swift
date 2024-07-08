//
//  SPMJCPluginMessage.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ServerPacket.Mojang.Java.Configuration {
    /// Mods and plugins can use this to send their data. Minecraft itself uses some [plugin channels](https://wiki.vg/Plugin_channel ). These internal channels are in the `minecraft` namespace.
    ///
    /// [More documentation on this](https://dinnerbone.com/blog/2012/01/13/minecraft-plugin-channels-messaging/ ).
    ///
    /// Note that the length of Data is known only from the packet length, since the packet has no length field of any kind.
    ///
    /// - Note: In Notchian server, the maximum data length is 32767 bytes.
    struct PluginMessage : ServerPacketMojangJavaConfigurationProtocol {
        public static let id:ServerPacket.Mojang.Java.Configuration = ServerPacket.Mojang.Java.Configuration.plugin_message
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let channel:Namespace = try packet.readIdentifier()
            let data:[UInt8] = try packet.readRemainingByteArray()
            return Self(channel: channel, data: data)
        }
        
        /// Name of the [plugin channel](https://wiki.vg/Plugin_channel) used to send the data.
        public let channel:Namespace
        /// Any data, depending on the channel. `minecraft:` channels are documented [here](https://wiki.vg/Plugin_channel ). The length of this array must be inferred from the packet length.
        public let data:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var values:[any PacketEncodableMojangJava] = [channel]
            values.append(contentsOf: data)
            return values
        }
    }
}
