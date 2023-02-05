//
//  EnchantmentOffer.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct EnchantmentOffer : Jsonable {
    public var type:EnchantmentType
    public var level:UInt16
    public var cost:UInt16
}
