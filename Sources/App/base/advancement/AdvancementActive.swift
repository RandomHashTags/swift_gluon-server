//
//  AdvancementActive.swift
//  
//
//  Created by Evan Anderson on 2/10/23.
//

import Foundation

public struct AdvancementActive : Hashable {
    public let identifier:String
    public var type : (any Advancement)? {
        return GluonServer.shared_instance.get_advancement(id: identifier)
    }
    public var value:Float
}
