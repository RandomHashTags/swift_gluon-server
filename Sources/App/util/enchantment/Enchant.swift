//
//  Enchant.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public struct Enchant : Hashable {
    public var type:UnsafePointer<EnchantmentType>
    public var level:UInt16
}
