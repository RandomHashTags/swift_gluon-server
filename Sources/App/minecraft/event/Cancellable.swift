//
//  Cancellable.swift
//  
//
//  Created by Evan Anderson on 2/22/23.
//

import Foundation

public protocol Cancellable {
    var isCancelled : Bool { get set }
}
