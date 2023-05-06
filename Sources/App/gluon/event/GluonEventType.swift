//
//  GluonEventType.swift
//  
//
//  Created by Evan Anderson on 4/27/23.
//

import Foundation

struct GluonEventType : EventType {
    static func parse(_ identifier: String) -> Self? {
        return GluonServer.shared_instance.get_event_type(identifier: identifier)
    }

    let identifier:String

    init(identifier: String) {
        self.identifier = identifier
        //try? GluonServer.shared_instance.register_event_type(type: self) // TODO: handle
    }
}
extension GluonEventType {
    static var chunk_load:GluonEventType = GluonEventType(identifier: "minecraft.chunk_load")
    static var chunk_unload:GluonEventType = GluonEventType(identifier: "minecraft.chunk_unload")

    static var entity_damage:GluonEventType = GluonEventType(identifier: "minecraft.entity_damage")
    static var entity_death:GluonEventType = GluonEventType(identifier: "minecraft.entity_death")
    static var entity_teleport:GluonEventType = GluonEventType(identifier: "minecraft.entity_teleport")

    static var player_change_game_mode:GluonEventType = GluonEventType(identifier: "minecraft.player_change_game_mode")
    static var player_item_consume:GluonEventType = GluonEventType(identifier: "minecraft.player_item_consume_event")
    static var player_join:GluonEventType = GluonEventType(identifier: "minecraft.player_join")
    static var player_quit:GluonEventType = GluonEventType(identifier: "minecraft.player_quit")
}
