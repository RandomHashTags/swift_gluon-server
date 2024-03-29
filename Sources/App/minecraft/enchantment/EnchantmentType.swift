//
//  EnchantmentType..swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public protocol EnchantmentType : MultilingualName, Identifiable where ID == String {
    var weight : UInt16 { get }
    var max_level : UInt16 { get }
    
    /// the ``EnchantmentType`` ids this enchantment type conflicts with.
    var conflicts_with : Set<String> { get }
    
    var target : any EnchantmentTarget { get }
    
    var is_treasure : Bool { get }
    var is_cursed : Bool { get }
}
public extension EnchantmentType {
    var is_treasure : Bool {
        return false
    }
    var is_cursed : Bool {
        return false
    }
    
    func conflicts_with(_ enchantment: any EnchantmentType) -> Bool {
        return conflicts_with.contains(enchantment.id)
    }
}
