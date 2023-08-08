//
//  CPMPStopSound.swift
//  
//
//  Created by Evan Anderson on 8/3/23.
//

import Foundation

public extension ClientPacketMojang.Play {
    struct StopSound : ClientPacketMojangPlayProtocol { // TODO: fix
        /// Controls which fields are present.
        public let flags:Int
        /// Only if flags is 3 or 1 (bit mask 0x1). See below. If not present, then sounds from all sources are cleared.
        public let source:VariableInteger?
        /// Only if flags is 2 or 3 (bit mask 0x2). A sound effect name, see [Custom Sound Effect](https://wiki.vg/Protocol#Custom_Sound_Effect ). If not present, then all sounds are cleared.
        public let sound:Namespace?
        
        public func encoded_values() throws -> [PacketEncodableMojang?] {
            var array:[PacketEncodableMojang?] = [flags]
            switch flags {
            case 1:
                array.append(source)
                break
            case 2:
                array.append(sound)
                break
            case 3:
                array.append(source)
                array.append(sound)
                break
            default:
                break
            }
            return array
        }
    }
}
