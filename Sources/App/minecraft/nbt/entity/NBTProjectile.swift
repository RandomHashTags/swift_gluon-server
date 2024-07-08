//
//  NBTProjectile.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTProjectile : NBTTag {
    var hasBeenShot : Bool { get }
    var leftOwner : Bool { get }
    var owner : UUID? { get }
}