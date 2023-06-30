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
}
