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
    
    public var packet : any ServerPacketMojangPlayProtocol.Type {
        switch self {
        case .confirm_teleportation:            return ServerPacketMojang.Play.ConfirmTeleportation.self
        case .query_block_entity_tag:           return ServerPacketMojang.Play.QueryBlockEntityTag.self
        case .change_difficulty:                return ServerPacketMojang.Play.ChangeDifficulty.self
        case .message_acknowledgement:          return ServerPacketMojang.Play.MessageAcknowledgment.self
        case .chat_command:                     return ServerPacketMojang.Play.ChatCommand.self
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
        case .player_action:                    return ServerPacketMojang.Play.PlayerAction.self
        case .player_command:                   return ServerPacketMojang.Play.PlayerCommand.self
        case .player_input:                     return ServerPacketMojang.Play.PlayerInput.self
        case .pong:                             return ServerPacketMojang.Play.Pong.self
        case .change_recipe_book_settings:      return ServerPacketMojang.Play.ChangeRecipeBookSettings.self
        case .set_seen_recipe:                  return ServerPacketMojang.Play.SetSeenRecipe.self
        case .rename_item:                      return ServerPacketMojang.Play.RenameItem.self
        case .resource_pack:                    return ServerPacketMojang.Play.ResourcePack.self
        case .seen_advancements:                return ServerPacketMojang.Play.SeenAdvancements.self
        case .select_trade:                     return ServerPacketMojang.Play.SelectTrade.self
        case .set_beacon_effect:                return ServerPacketMojang.Play.SetBeaconEffect.self
        case .set_held_item:                    return ServerPacketMojang.Play.SetHeldItem.self
        case .program_command_block:            return ServerPacketMojang.Play.ProgramCommandBlock.self
        case .program_command_block_minecart:   return ServerPacketMojang.Play.ProgramCommandBlockMinecart.self
        case .set_creative_mode_slot:           return ServerPacketMojang.Play.SetCreativeMoveSlot.self
        case .program_jigsaw_block:             return ServerPacketMojang.Play.ProgramJigsawBlock.self
        case .program_structure_block:          return ServerPacketMojang.Play.ProgramStructureBlock.self
        case .update_sign:                      return ServerPacketMojang.Play.UpdateSign.self
        case .swing_arm:                        return ServerPacketMojang.Play.SwingArm.self
        case .teleport_to_entity:               return ServerPacketMojang.Play.TeleportToEntity.self
        case .use_item_on:                      return ServerPacketMojang.Play.UseItemOn.self
        case .use_item:                         return ServerPacketMojang.Play.UseItem.self
        }
    }
    
    func process(_ client: ServerMojangClient) throws {
        try packet.process(client)
    }
}
