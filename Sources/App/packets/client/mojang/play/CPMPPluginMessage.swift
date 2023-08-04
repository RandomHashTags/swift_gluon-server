//
//  CPMPPluginMessage.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    /// Mods and plugins can use this to send their data. Minecraft itself uses several plugin channels. These internal channels are in the `minecraft` namespace.
    ///
    /// More information on how it works on Dinnerbone's blog (https://dinnerbone.com/blog/2012/01/13/minecraft-plugin-channels-messaging/ ). More documentation about internal and popular registered channels can be found at https://wiki.vg/Plugin_channel .
    ///
    /// In Notchian client, the maximum data length is 1048576 bytes.
    struct PluginMessage : ClientPacketMojangProtocol {
        /// Name of the plugin channel used to send the data.
        let channel:String // TODO: fix | make `Identifier`
        /// Any data. The length of this array must be inferred from the packet length.
        let data:Data
    }
}
