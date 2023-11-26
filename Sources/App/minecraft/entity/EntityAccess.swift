//
//  EntityAccess.swift
//
//
//  Created by Evan Anderson on 11/26/23.
//

import Foundation

public protocol EntityAccess {
    var id : UInt64 { get }
    var uuid : UUID { get }
    var should_be_saved : Bool { get }
    var is_always_ticking : Bool { get }
}
