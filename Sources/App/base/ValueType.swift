//
//  ValueType.swift
//  
//
//  Created by Evan Anderson on 2/3/23.
//

import Foundation

public enum ValueType : Jsonable {
    case string
    case char//(Int8)
    case char_unsigned//(UInt8)
    case short//(Int16)
    case short_unsigned//(UInt16)
    
    case integer
    case integer_unsigned
    case long
    case long_unsigned // UInt64
    
    case float
    case double
    
    case boolean
    
    case item_stack
}
