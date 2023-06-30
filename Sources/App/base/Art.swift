//
//  Art.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol Art : Identifiable where ID == String {
    /// measured in blocks
    var width : UInt { get }
    /// measured in blocks
    var height : UInt { get }
}
