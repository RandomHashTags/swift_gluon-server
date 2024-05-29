//
//  NBTTameable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTTameable : NBTEntity {
    var owner : UUID? { get }
    var sitting : Bool { get }
}