//
//  NBTBreedable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

import Foundation

public protocol NBTBreedable : NBTEntity {
    var age : Int { get }
    var forced_age : Int { get }
    var in_love : Int { get }
    var love_cause : UUID { get }
}