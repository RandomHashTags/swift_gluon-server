//
//  CPMPPluginMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Play {
    /// Mods and plugins can use this to send their data. Minecraft itself uses several plugin channels. These internal channels are in the `minecraft` namespace.
    ///
    /// More information on how it works on Dinnerbone's blog (https://dinnerbone.com/blog/2012/01/13/minecraft-plugin-channels-messaging/ ). More documentation about internal and popular registered channels can be found at https://wiki.vg/Plugin_channel .
    ///
    /// In Notchian client, the maximum data length is 1048576 bytes.
    struct PluginMessage : ClientPacket.Mojang.Java.PlayProtocol {
        public static let id:ClientPacket.Mojang.Java.Play = ClientPacket.Mojang.Java.Play.plugin_message
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let channel:Namespace = try packet.readIdentifier()
            let data:[UInt8] = try packet.readRemainingByteArray()
            return Self(channel: channel, data: data)
        }
        
        /// Name of the plugin channel used to send the data.
        public let channel:Namespace
        /// Any data. The length of this array must be inferred from the packet length.
        public let data:[UInt8]
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var array:[(any PacketEncodableMojangJava)?] = [channel]
            array.append(contentsOf: data)
            return array
        }
    }
}
