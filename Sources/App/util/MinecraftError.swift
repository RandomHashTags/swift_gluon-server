//
//  MinecraftError.swift
//
//
//  Created by Evan Anderson on 11/18/23.
//

import Foundation

public struct MinecraftError : Error, CustomStringConvertible {
    public let sender:String, message:String
    
    public var description : String {
        return sender + ": " + message
    }
}
