//
//  ChatManager.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol ChatManager : AnyActor {
    func send(sender: String, message: String) async
}
