//
//  GluonChatManager.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

actor GluonChatManager : ChatManager {
    private var history:[any ChatMessage] = []
    
    func send(sender: any CommandSender, receiver: String?, message: String) async {
        let msg:GluonChatMessage = GluonChatMessage(id: UUID(), timestamp: Date(), sender: sender, receiver: receiver, message: message)
        history.append(msg)
        if let receiver:String = receiver {
            
        } else {
            
        }
        
        let chat_packet:ChatPacketMojang = ChatPacketMojang(
            text: message,
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
        )
        for player in ServerMojang.instance.player_connections {
            do {
                try player.send_packet(chat_packet)
            } catch {
                let uuid:UUID? = player.player?.uuid
                print("GluonChatManager;send;encountered error while trying to send chat packet to player with uuid \(String(describing: uuid));error=\(error)")
            }
        }
    }
}
