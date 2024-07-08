//
//  BanEntry.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BanEntry : Hashable {
    /// the ``Player``'s UUID that banned `target`
    public let bannedBy:UUID
    public let target:String
    public let banTime:Date
    public let expiration:Date?
    public let reason:String?
}
