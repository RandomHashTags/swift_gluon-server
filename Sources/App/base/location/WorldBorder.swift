//
//  WorldBorder.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol WorldBorder {
    var size : Double { get set }
    var center : Vector { get set }
    
    var warning_distance : UInt { get set }
}
