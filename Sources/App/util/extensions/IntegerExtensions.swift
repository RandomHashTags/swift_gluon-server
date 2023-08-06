//
//  IntegerExtensions.swift
//  
//
//  Created by Evan Anderson on 8/5/23.
//

import Foundation

extension UInt8 {
    var char : Character {
        return Character(UnicodeScalar(self))
    }
}
