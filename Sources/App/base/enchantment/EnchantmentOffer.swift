//
//  EnchantmentOffer.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol EnchantmentOffer : Hashable {
    var type_id : String { get }
    var type : (any EnchantmentType)? { get set }
    /// The enchantment level of ``EnchantmentType``of this offer.
    var level : UInt16 { get set }
    /// The amount of experience levels this offer costs.
    var cost : UInt16 { get set }
}

public extension EnchantmentOffer {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type_id)
        hasher.combine(level)
        hasher.combine(cost)
    }
}
