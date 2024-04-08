//
//  MPVJava.Java.swift
//
//
//  Created by Evan Anderson on 8/6/23.
//

import Foundation

// https://wiki.vg/Protocol_version_numbers
public extension MinecraftProtocolVersion {
    enum Java : Int, MinecraftProtocolVersionProtocol, PacketEncodableMojangJava {
        case unknown = -999
        
        // MARK: Releases
        /// 1.20.3 & 1.20.4
        case v1_20_3 = 765
        case v1_20_2 = 764
        /// 1.20 & 1.20.1
        case v1_20   = 763
        
        case v1_19_4 = 762
        case v1_19_3 = 761
        /// 1.19.1 & 1.19.2
        case v1_19_1 = 760
        case v1_19   = 759
        
        case v1_18_2 = 758
        case v1_18   = 757
        
        case v1_17_1 = 756
        case v1_17   = 755
        
        case v1_16_4 = 754
        case v1_16_3 = 753
        case v1_16_2 = 751
        case v1_16_1 = 736
        case v1_16   = 735
        
        case v1_15_2 = 578
        case v1_15_1 = 575
        case v1_15   = 573
        
        case v1_14_4 = 498
        case v1_14_3 = 490
        case v1_14_2 = 485
        case v1_14_1 = 480
        case v1_14   = 477
        
        case v1_13_2 = 404
        case v1_13_1 = 401
        case v1_13   = 393
        
        case v1_12_2 = 340
        case v1_12_1 = 338
        case v1_12   = 335
        
        case v1_11_1 = 316
        case v1_11   = 315
        
        case v1_10   = 210
        
        case v1_9_3  = 110
        case v1_9_2  = 109
        case v1_9_1  = 108
        case v1_9    = 107
        
        case v1_8    = 47
        
        case v1_7_6  = 5
        case v1_7_2  = 4
        
        
        // MARK: Snapshots
        case v23w31a = 0x40000090
        
        
    }
}
