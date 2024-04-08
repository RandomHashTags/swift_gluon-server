//
//  GluonEventType.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

struct GluonEventType : EventType {
    let id:String

    init(id: String) {
        self.id = id
        //try? GluonServer.shared.register_event_type(type: self) // TODO: handle
    }
}
extension GluonEventType {
    static var chunk_load:GluonEventType = GluonEventType(id: "minecraft.chunk_load")
    static var chunk_unload:GluonEventType = GluonEventType(id: "minecraft.chunk_unload")

    static var entity_damage:GluonEventType = GluonEventType(id: "minecraft.entity_damage")
    static var entity_death:GluonEventType = GluonEventType(id: "minecraft.entity_death")
    static var entity_teleport:GluonEventType = GluonEventType(id: "minecraft.entity_teleport")

    static var player_change_game_mode:GluonEventType = GluonEventType(id: "minecraft.player_change_game_mode")
    static var player_item_consume:GluonEventType = GluonEventType(id: "minecraft.player_item_consume_event")
    static var player_join:GluonEventType = GluonEventType(id: "minecraft.player_join")
    static var player_quit:GluonEventType = GluonEventType(id: "minecraft.player_quit")
}
