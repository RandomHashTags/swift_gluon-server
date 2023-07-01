//
//  GluonChatManager.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

actor GluonChatManager : ChatManager {
    
    private var history:[any ChatMessage] = []
    
    func send(sender: String, message: String) async {
    }
}
