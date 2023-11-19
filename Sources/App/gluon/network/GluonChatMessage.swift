//
//  GluonChatMessage.swift
//
//
//  Created by Evan Anderson on 11/18/23.
//

import Foundation

struct GluonChatMessage : ChatMessage {
    let id:UUID
    let timestamp:Date
    let sender:any CommandSender
    let receiver:String?
    let message: String
}
