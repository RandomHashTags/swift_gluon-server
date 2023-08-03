//
//  ChatMessage.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol ChatMessage : Identifiable where ID == UUID {
    var timestamp : Date { get }
    var sender : any CommandSender { get }
    var message : String { get }
}
