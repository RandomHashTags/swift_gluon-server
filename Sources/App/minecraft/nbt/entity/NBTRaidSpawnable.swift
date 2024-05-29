//
//  NBTRaidSpawnable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

public protocol NBTRaidSpawnable : NBTEntity {
    var can_join_raid : Bool { get }
    var patrol_leader : Bool { get }
    var patrolling : Bool { get }
    var patrol_target : String { get } // TODO: fix
    var raid_id : Int { get }
    var wave : Int { get }
}