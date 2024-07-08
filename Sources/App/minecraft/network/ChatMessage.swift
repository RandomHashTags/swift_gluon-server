//
//  ChatMessage.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public struct ChatMessage : Identifiable {
    public let id:String
    public let timestamp:Date
    public var sender:any CommandSender
    public let receiver:String?
    public let message:String
}
