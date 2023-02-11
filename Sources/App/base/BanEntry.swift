//
//  BanEntry.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BanEntry : Jsonable {
    public let target:String
    public let ban_time:UInt64
    public let expiration:UInt64?
    public let reason:String?
}
