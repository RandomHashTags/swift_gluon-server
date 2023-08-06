//
//  ServerPacketMojangErrors.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public enum ServerPacketMojangErrors {
    
    public enum ProtocolVersion : Error, CustomStringConvertible {
        case doesnt_exist(id: Int)
        
        public var description : String {
            switch self {
            case .doesnt_exist(let id):
                return "`MinecraftProtocolVersion` with rawValue \(id) doesn't exist"
            }
        }
    }
    public enum Status : Error, CustomStringConvertible {
        case doesnt_exist(id: Int)
        
        public var description : String {
            switch self {
            case .doesnt_exist(let id):
                return "`ServerPacketMojang.Status` with rawValue \(id) doesn't exist"
            }
        }
    }
    
}
