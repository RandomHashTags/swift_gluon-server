//
//  EnchantmentType..swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct EnchantmentType : Jsonable {
    public let identifier:String
    public let name:MultilingualStrings
    public var weight:UInt16
    public var max_level:UInt16
}
