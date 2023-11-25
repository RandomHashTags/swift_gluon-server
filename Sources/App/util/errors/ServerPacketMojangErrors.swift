//
//  ServerPacketMojangErrors.swift
//  
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

public enum ServerPacketMojangErrors {
    
    public enum VarIntEnum : Error, CustomStringConvertible {
        case doesnt_exist(type: Any.Type, id: Int)
        
        public var description: String {
            switch self {
            case .doesnt_exist(let type, let id):
                return "`\(type)` with rawValue \(id) doesn't exist"
            }
        }
    }
    
}
