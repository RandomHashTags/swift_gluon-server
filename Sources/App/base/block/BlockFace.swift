//
//  BlockFace.swift
//  
//
//  Created by Evan Anderson on 2/5/23.
//

import Foundation

public struct BlockFace : Jsonable {
    public let identifier:String
    public let opposite_face_identifier:String
}
