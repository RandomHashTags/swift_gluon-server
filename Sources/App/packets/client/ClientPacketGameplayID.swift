//
//  ClientPacketGameplayID.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public protocol ClientPacketGameplayID : RawRepresentable where RawValue == UInt {
    func decode<T>(data: Data) -> T?
}
