//
//  Tickable.swift
//  
//
//  Created by Evan Anderson on 2/16/23.
//

import Foundation

internal protocol Tickable {
    func tick(_ server: GluonServer)
}
