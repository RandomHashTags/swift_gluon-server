//
//  CPMSStatusResponse.swift
//  
//
//  Created by Evan Anderson on 8/4/23.
//

import Foundation

public extension ClientPacketMojang.Status {
    struct StatusResponse : ClientPacketMojangStatusProtocol {
        public static let id:ClientPacketMojangStatus = ClientPacketMojangStatus.status_response
        
        public static func parse(_ packet: GeneralPacketMojang) throws -> Self {
            let json_response:String = try packet.read_string()
            return Self(json_response: json_response)
        }
        
        /// See https://wiki.vg/Server_List_Ping#Response ; as with all strings this is prefixed by its length as a VarInt.
        public let json_response:String
        
        init(json_response: String) {
            self.json_response = json_response
        }
        init(version: MinecraftProtocolVersion, motd: String, enforces_secure_chat: Bool, online_players_count: Int) throws {
            let status_request:ServerPacketMojangStatusResponse = ServerPacketMojangStatusResponse(
                version: ServerPacketMojangStatusResponse.Version(
                    name: version.name,
                    protocol: version.rawValue
                ),
                players: ServerPacketMojangStatusResponse.Players(
                    max: 10,
                    online: online_players_count,
                    sample: [
                        ServerPacketMojangStatusResponse.Player(name: "thinkofdeath", id: UUID("4566e69f-c907-48ee-8d71-d7ba5aa00d20")!)
                    ]
                ),
                description: ChatPacketMojang(
                    text: motd,
                    translate: nil,
                    with: nil,
                    score: nil,
                    bold: nil,
                    italic: nil,
                    underlined: nil,
                    strikethrough: nil,
                    obfuscated: nil,
                    font: nil,
                    color: nil,
                    insertion: nil,
                    clickEvent: nil,
                    hoverEvent: nil,
                    extra: nil
                ),
                favicon: nil,
                enforcesSecureChat: enforces_secure_chat,
                previewsChat: true
            )
            let data:Data = try JSONEncoder().encode(status_request)
            guard let string:String = String(data: data, encoding: .utf8) else {
                throw DecodingError.valueNotFound(String.self, DecodingError.Context.init(codingPath: [], debugDescription: "couldn't convert status_request packet to JSON"))
            }
            json_response = string
        }
        
        public func encoded_values() throws -> [(any PacketEncodableMojang)?] {
            return [json_response]
        }
    }
}
