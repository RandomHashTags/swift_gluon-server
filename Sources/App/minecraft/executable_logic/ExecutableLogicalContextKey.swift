//
//  ExecutableLogicalContextKey.swift
//  
//
//  Created by Evan Anderson on 3/5/23.
//

import Foundation

public struct ExecutableLogicalContextKey {
    public let identifier:String
    public let return_type:ValueType
    //case health
    //case health_maximum
    
    //case ticks_lived
    
    //case custom
    
    func get_returned_value(event: any Event) -> Any? {
        return nil
    }
    var returned_value : Any? {
        return nil
    }
}
