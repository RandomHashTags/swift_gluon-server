//
//  MPVBedrock.swift
//
//
//  Created by Evan Anderson on 11/25/23.
//

import Foundation

// https://wiki.vg/Bedrock_Protocol_version_numbers
public extension MinecraftProtocolVersion {
    enum Bedrock : Int, MinecraftProtocolVersionProtocol {
        case v1_19_83    = 582
        case v1_19_70    = 575
        
        /// - `1.19.70.20`
        /// - `1.19.70.21`
        case v1_19_70_20 = 569
        
        case v1_19_63    = 568
        
        /// - `1.19.60.26`
        /// - `1.19.60.27`
        /// - `1.19.61`
        /// - `1.19.62`
        case v1_19_60_26 = 567
        
        case v1_19_60_25 = 565
        case v1_19_60_24 = 563
        
        /// - `1.19.60.22`
        /// - `1.19.60.23`
        case v1_19_60_22 = 562
    }
}
