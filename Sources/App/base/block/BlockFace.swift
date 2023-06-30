//
//  BlockFace.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public protocol AnyBlockFace : Hashable {
    var opposite_face_identifier : String { get }
}

public protocol BlockFace : AnyBlockFace, Identifiable where ID == String {
}
