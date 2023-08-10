//
//  ServerPacketMojangPlay.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public enum ServerPacketMojangPlay : UInt8, PacketGameplayID {
    case confirm_teleportation = 0
    case query_block_entity_tag = 1
    case change_difficulty
    case message_acknowledgement
    case chat_command
    case chat_message
    case player_session
    case client_command
    case client_information
    case command_suggestions_request
    case click_container_button
    case click_container
    case close_container
    case plugin_message
    case edit_book
    case query_entity_tag
    case interact
    case jigsaw_generate
    case keep_alive
    case lock_difficulty
    case set_player_position
    case set_player_position_and_rotation
    case set_player_rotation
    case set_player_on_ground
    case move_vehicle
    case paddle_boat
    case pick_item
    case place_recipe
    case player_abilities
    case player_action
    case player_command
    case player_input
    case pong
    case change_recipe_book_settings
    case set_seen_recipe
    case rename_item
    case resource_pack
    case seen_advancements
    case select_trade
    case set_beacon_effect
    case set_held_item
    case program_command_block
    case program_command_block_minecart
    case set_creative_mode_slot
    case program_jigsaw_block
    case program_structure_block
    case update_sign
    case swing_arm
    case teleport_to_entity
    case use_item_on
    case use_item
    
    public var packet : (any ServerPacketMojangProtocol.Type)? {
        switch self {
        case .confirm_teleportation:            return ServerPacketMojang.Play.ConfirmTeleportation.self
        case .query_block_entity_tag:           return ServerPacketMojang.Play.QueryBlockEntityTag.self
        case .message_acknowledgement:          return ServerPacketMojang.Play.MessageAcknowledgment.self
            
        case .chat_message:                     return ServerPacketMojang.Play.ChatMessage.self
        case .player_session:                   return ServerPacketMojang.Play.PlayerSession.self
        case .client_command:                   return ServerPacketMojang.Play.ClientCommand.self
        case .client_information:               return ServerPacketMojang.Play.ClientInformation.self
        case .command_suggestions_request:      return ServerPacketMojang.Play.CommandSuggestionsRequest.self
        case .click_container_button:           return ServerPacketMojang.Play.ClickContainerButton.self
        case .click_container:                  return ServerPacketMojang.Play.ClickContainer.self
        case .close_container:                  return ServerPacketMojang.Play.CloseContainer.self
        case .plugin_message:                   return ServerPacketMojang.Play.PluginMessage.self
        case .edit_book:                        return ServerPacketMojang.Play.EditBook.self
        case .query_entity_tag:                 return ServerPacketMojang.Play.QueryEntityTag.self
        case .interact:                         return ServerPacketMojang.Play.Interact.self
        case .jigsaw_generate:                  return ServerPacketMojang.Play.JigsawGenerate.self
        case .keep_alive:                       return ServerPacketMojang.Play.KeepAlive.self
        case .lock_difficulty:                  return ServerPacketMojang.Play.LockDifficulty.self
        case .set_player_position:              return ServerPacketMojang.Play.SetPlayerPosition.self
        case .set_player_position_and_rotation: return ServerPacketMojang.Play.SetPlayerPositionAndRotation.self
        case .set_player_rotation:              return ServerPacketMojang.Play.SetPlayerRotation.self
        case .set_player_on_ground:             return ServerPacketMojang.Play.SetPlayerOnGround.self
        case .move_vehicle:                     return ServerPacketMojang.Play.MoveVehicle.self
        case .paddle_boat:                      return ServerPacketMojang.Play.PaddleBoat.self
        case .pick_item:                        return ServerPacketMojang.Play.PickItem.self
        case .place_recipe:                     return ServerPacketMojang.Play.PlaceRecipe.self
        case .player_abilities:                 return ServerPacketMojang.Play.PlayerAbilities.self
            
        default:
            return nil
        }
    }
}
