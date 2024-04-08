//
//  AdvancementActive.swift
//  
//
//  Created by Evan Anderson on 2/10/23.
//

import Foundation

public struct AdvancementActive : Hashable {
    public let type_id:String
    public var type : (any Advancement)? {
        return GluonServer.shared.get_advancement(id: type_id)
    }
    public var value:Double
}
