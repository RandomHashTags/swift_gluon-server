//
//  ServerPacketMojangJavaPlay.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public extension ServerPacket.Mojang.Java {
    enum Play : UInt8, PacketGameplayID {
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
        
        public var packet : any ServerPacketMojangJavaPlayProtocol.Type {
            switch self {
            case .confirm_teleportation:            return ServerPacket.Mojang.Java.Play.ConfirmTeleportation.self
            case .query_block_entity_tag:           return ServerPacket.Mojang.Java.Play.QueryBlockEntityTag.self
            case .change_difficulty:                return ServerPacket.Mojang.Java.Play.ChangeDifficulty.self
            case .message_acknowledgement:          return ServerPacket.Mojang.Java.Play.MessageAcknowledgment.self
            case .chat_command:                     return ServerPacket.Mojang.Java.Play.ChatCommand.self
            case .chat_message:                     return ServerPacket.Mojang.Java.Play.ChatMessage.self
            case .player_session:                   return ServerPacket.Mojang.Java.Play.PlayerSession.self
            case .client_command:                   return ServerPacket.Mojang.Java.Play.ClientCommand.self
            case .client_information:               return ServerPacket.Mojang.Java.Play.ClientInformation.self
            case .command_suggestions_request:      return ServerPacket.Mojang.Java.Play.CommandSuggestionsRequest.self
            case .click_container_button:           return ServerPacket.Mojang.Java.Play.ClickContainerButton.self
            case .click_container:                  return ServerPacket.Mojang.Java.Play.ClickContainer.self
            case .close_container:                  return ServerPacket.Mojang.Java.Play.CloseContainer.self
            case .plugin_message:                   return ServerPacket.Mojang.Java.Play.PluginMessage.self
            case .edit_book:                        return ServerPacket.Mojang.Java.Play.EditBook.self
            case .query_entity_tag:                 return ServerPacket.Mojang.Java.Play.QueryEntityTag.self
            case .interact:                         return ServerPacket.Mojang.Java.Play.Interact.self
            case .jigsaw_generate:                  return ServerPacket.Mojang.Java.Play.JigsawGenerate.self
            case .keep_alive:                       return ServerPacket.Mojang.Java.Play.KeepAlive.self
            case .lock_difficulty:                  return ServerPacket.Mojang.Java.Play.LockDifficulty.self
            case .set_player_position:              return ServerPacket.Mojang.Java.Play.SetPlayerPosition.self
            case .set_player_position_and_rotation: return ServerPacket.Mojang.Java.Play.SetPlayerPositionAndRotation.self
            case .set_player_rotation:              return ServerPacket.Mojang.Java.Play.SetPlayerRotation.self
            case .set_player_on_ground:             return ServerPacket.Mojang.Java.Play.SetPlayerOnGround.self
            case .move_vehicle:                     return ServerPacket.Mojang.Java.Play.MoveVehicle.self
            case .paddle_boat:                      return ServerPacket.Mojang.Java.Play.PaddleBoat.self
            case .pick_item:                        return ServerPacket.Mojang.Java.Play.PickItem.self
            case .place_recipe:                     return ServerPacket.Mojang.Java.Play.PlaceRecipe.self
            case .player_abilities:                 return ServerPacket.Mojang.Java.Play.PlayerAbilities.self
            case .player_action:                    return ServerPacket.Mojang.Java.Play.PlayerAction.self
            case .player_command:                   return ServerPacket.Mojang.Java.Play.PlayerCommand.self
            case .player_input:                     return ServerPacket.Mojang.Java.Play.PlayerInput.self
            case .pong:                             return ServerPacket.Mojang.Java.Play.Pong.self
            case .change_recipe_book_settings:      return ServerPacket.Mojang.Java.Play.ChangeRecipeBookSettings.self
            case .set_seen_recipe:                  return ServerPacket.Mojang.Java.Play.SetSeenRecipe.self
            case .rename_item:                      return ServerPacket.Mojang.Java.Play.RenameItem.self
            case .resource_pack:                    return ServerPacket.Mojang.Java.Play.ResourcePack.self
            case .seen_advancements:                return ServerPacket.Mojang.Java.Play.SeenAdvancements.self
            case .select_trade:                     return ServerPacket.Mojang.Java.Play.SelectTrade.self
            case .set_beacon_effect:                return ServerPacket.Mojang.Java.Play.SetBeaconEffect.self
            case .set_held_item:                    return ServerPacket.Mojang.Java.Play.SetHeldItem.self
            case .program_command_block:            return ServerPacket.Mojang.Java.Play.ProgramCommandBlock.self
            case .program_command_block_minecart:   return ServerPacket.Mojang.Java.Play.ProgramCommandBlockMinecart.self
            case .set_creative_mode_slot:           return ServerPacket.Mojang.Java.Play.SetCreativeMoveSlot.self
            case .program_jigsaw_block:             return ServerPacket.Mojang.Java.Play.ProgramJigsawBlock.self
            case .program_structure_block:          return ServerPacket.Mojang.Java.Play.ProgramStructureBlock.self
            case .update_sign:                      return ServerPacket.Mojang.Java.Play.UpdateSign.self
            case .swing_arm:                        return ServerPacket.Mojang.Java.Play.SwingArm.self
            case .teleport_to_entity:               return ServerPacket.Mojang.Java.Play.TeleportToEntity.self
            case .use_item_on:                      return ServerPacket.Mojang.Java.Play.UseItemOn.self
            case .use_item:                         return ServerPacket.Mojang.Java.Play.UseItem.self
            }
        }
        
        func server_received(_ client: ServerMojangClientJava) throws {
            try packet.server_received(client)
        }
    }
}
