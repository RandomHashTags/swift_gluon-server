//
//  ServerTickChangeListener.swift
//
//
//  Created by Evan Anderson on 6/30/23.
//

import Foundation

public protocol ServerTickChangeListener {
    mutating func server_tps_slowed(to tps: UInt8, divisor: UInt16)
    mutating func server_tps_increased(to tps: UInt8, multiplier: UInt16)
}
