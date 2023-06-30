//
//  BanEntry.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BanEntry : Hashable {
    /// the ``Player``'s UUID that banned `target`
    public let banned_by:UUID
    public let target:String
    public let ban_time:UInt64
    public let expiration:UInt64?
    public let reason:String?
}
