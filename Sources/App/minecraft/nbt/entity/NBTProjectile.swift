//
//  NBTProjectile.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTProjectile : NBTTag {
    var has_been_shot : Bool { get }
    var left_owner : Bool { get }
    var owner : UUID? { get }
}