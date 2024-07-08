//
//  NBTRaidSpawnable.swift
//  
//
//  Created by Evan Anderson on 5/28/24.
//

public protocol NBTRaidSpawnable : NBTEntity {
    var canJoinRaid : Bool { get }
    var patrolLeader : Bool { get }
    var patrolling : Bool { get }
    var patrolTarget : String { get } // TODO: fix
    var raidID : Int { get }
    var wave : Int { get }
}