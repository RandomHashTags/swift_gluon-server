//
//  PropertyWrapper.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct PropertyWrapper<T : Hashable> : Hashable {
    public var wrappedValue:T
}
