//
//  NBTAngerable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTAngerable : NBTEntity {
    var anger_time : Int { get }
    var angry_at : UUID? { get }
}