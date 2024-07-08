//
//  CPMJCResourcePack.swift
//
//
//  Created by Evan Anderson on 11/15/23.
//

import Foundation

extension ClientPacket.Mojang.Java.Configuration {
    struct ResourcePack : ClientPacket.Mojang.Java.ConfigurationProtocol {
        public static let id:ClientPacket.Mojang.Java.Configuration = ClientPacket.Mojang.Java.Configuration.resource_pack
        
        /// The URL to the resource pack.
        public let url:String
        /// A 40 character hexadecimal and lowercase [SHA-1](http://en.wikipedia.org/wiki/SHA-1) hash of the resource pack file.
        /// If it's not a 40 character hexadecimal string, the client will not use it for hash verification and likely waste bandwidth — but it will still treat it as a unique id
        public let hash:String
        /// The notchian client will be forced to use the resource pack from the server. If they decline they will be kicked from the server.
        public let forced:Bool
        /// `true` If the next field will be sent `false` otherwise. When `false`, this is the end of the packet.
        public let has_prompt_message:Bool
        /// This is shown in the prompt making the client accept or decline the resource pack.
        public let prompt_message:ChatPacketMojang?
        
        public func encoded_values() throws -> [(any PacketEncodableMojangJava)?] {
            var values:[(any PacketEncodableMojangJava)?] = [url, hash, forced, has_prompt_message]
            if has_prompt_message {
                values.append(prompt_message)
            }
            return values
        }
    }
}
