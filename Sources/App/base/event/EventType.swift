//
//  EventType.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public struct EventType : Hashable {
    public static func parse(_ identifier: String) -> EventType? {
        return GluonServer.get_event_type(identifier: identifier)
    }
    
    public let identifier:String
    
    public init(identifier: String) {
        self.identifier = identifier
        try? GluonServer.register_event_type(type: self) // TODO: handle
    }
}
public extension EventType {
    static var chunk_load:EventType = EventType(identifier: "minecraft.chunk_load")
    static var chunk_unload:EventType = EventType(identifier: "minecraft.chunk_unload")
    
    static var entity_damage:EventType = EventType(identifier: "minecraft.entity_damage")
    static var entity_death:EventType = EventType(identifier: "minecraft.entity_death")
    static var entity_teleport:EventType = EventType(identifier: "minecraft.entity_teleport")
    
    static var player_change_game_mode:EventType = EventType(identifier: "minecraft.player_change_game_mode")
    static var player_item_consume:EventType = EventType(identifier: "minecraft.player_item_consume_event")
    static var player_join:EventType = EventType(identifier: "minecraft.player_join")
    static var player_quit:EventType = EventType(identifier: "minecraft.player_quit")
}
