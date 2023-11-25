//
//  MinecraftProtocolVersion.swift
//
//
//  Created by Evan Anderson on 11/25/23.
//

import Foundation

public enum MinecraftProtocolVersion {
}

public protocol MinecraftProtocolVersionProtocol : Hashable, Codable, RawRepresentable where RawValue == Int {
    var name : String { get }
}
public extension MinecraftProtocolVersionProtocol {
    var name : String {
        let string:String = "\(self)".replacingOccurrences(of: "_", with: ".")
        return String(string[string.index(after: string.startIndex)..<string.endIndex])
    }
}
