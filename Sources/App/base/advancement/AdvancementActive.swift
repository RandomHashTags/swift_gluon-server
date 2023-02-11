//
//  AdvancementActive.swift
//  
//
//  Created by Evan Anderson on 2/10/23.
//

import Foundation

public struct AdvancementActive : Jsonable {
    public let identifier:String
    public var type : Advancement? {
        return GluonServer.get_advancement(identifier: identifier)
    }
    public var value:Float
}
