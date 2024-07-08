//
//  Art.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct Art : Identifiable {
    public let id:String
    
    /// measured in blocks
    public let width : UInt
    /// measured in blocks
    public let height:UInt
}
