//
//  NBTAngerable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTAngerable : NBTEntity {
    var angerTime : Int { get }
    var angryAt : UUID? { get }
}