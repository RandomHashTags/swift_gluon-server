//
//  CPMJPlay.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public extension ClientPacket.Mojang.Java {
    enum Play : UInt8, PacketGameplayID {
        case bundle_delimiter = 0
        case spawn_entity =     1
        case spawn_experience_orb
        case spawn_player
        case entity_animation
        case award_statistic
        case acknowledge_block_change
        case set_block_destroy_stage
        case block_entity_data
        case block_action
        case block_update
        case boss_bar
        case change_difficulty
        case chunk_biomes
        case clear_titles
        case command_suggestions_response
        case commands
        case close_container
        case set_container_content
        case set_container_property
        case set_container_slot
        case set_cooldown
        case chat_suggestions
        case plugin_message
        case damage_event
        case delete_message
        case disconnect
        case disguised_chat_message
        case entity_event
        case explosion
        case unload_chunk
        case game_event
        case open_horse_screen
        case hurt_animation
        case initialize_world_border
        case keep_alive
        case chunk_daa_and_update_light
        case world_event
        case particle
        case update_light
        case login
        case map_data
        case merchant_offers
        case update_entity_position
        case update_entity_position_and_rotation
        case update_entity_rotation
        case move_vehicle
        case open_book
        case open_screen
        case open_sign_editor
        case ping
        case place_ghost_recipe
        case player_abilities
        case player_chat_message
        case end_combat
        case enter_combat
        case combat_death
        case player_info_remove
        case player_info_update
        case look_at
        case synchronize_player_position
        case update_recipe_book
        case remove_entities
        case remote_entity_effect
        case resource_pack
        case respawn
        case set_head_rotation
        case update_section_blocks
        case select_advancements_tab
        case server_data
        case set_action_bar_text
        case set_border_center
        case set_border_lerp_size
        case set_border_size
        case set_border_warning_delay
        case set_border_warning_distance
        case set_camera
        case set_held_item
        case set_center_chunk
        case set_render_distance
        case set_default_spawn_position
        case display_objective
        case set_entity_metadata
        case link_entities
        case set_entity_velocity
        case set_equipment
        case set_experience
        case set_health
        case update_objectives
        case set_passengers
        case update_teams
        case update_score
        case set_simulation_distance
        case set_subtitle_text
        case update_time
        case set_title_text
        case set_title_animation_times
        case entity_sound_effect
        case sound_effect
        case stop_sound
        case system_chat_message
        case set_tab_list_header_and_footer
        case tag_query_response
        case pickup_item
        case teleport_entity
        case update_advancements
        case update_attributes
        case feature_flags
        case entity_effect
        case update_recipes
        case update_tags
        
        public var packet : (any ClientPacketMojangJavaProtocol.Type)? {
            switch self {
            case .spawn_entity:                   return ClientPacket.Mojang.Java.Play.SpawnEntity.self
            case .spawn_experience_orb:           return ClientPacket.Mojang.Java.Play.SpawnExperienceOrb.self
            case .spawn_player:                   return ClientPacket.Mojang.Java.Play.SpawnPlayer.self
            case .entity_animation:               return ClientPacket.Mojang.Java.Play.EntityAnimation.self
            case .award_statistic:                return ClientPacket.Mojang.Java.Play.AwardStatistics.self
            case .acknowledge_block_change:       return ClientPacket.Mojang.Java.Play.AcknowledgeBlockChange.self
            case .set_block_destroy_stage:        return ClientPacket.Mojang.Java.Play.SetBlockDestroyStage.self
                
            case .block_action:                   return ClientPacket.Mojang.Java.Play.BlockAction.self
            case .block_update:                   return ClientPacket.Mojang.Java.Play.BlockUpdate.self
            case .boss_bar:                       return ClientPacket.Mojang.Java.Play.BossBar.self
            case .change_difficulty:              return ClientPacket.Mojang.Java.Play.ChangeDifficulty.self
            case .chunk_biomes:                   return ClientPacket.Mojang.Java.Play.ChunkBiomes.self
            case .clear_titles:                   return ClientPacket.Mojang.Java.Play.ClearTitles.self
            case .command_suggestions_response:   return ClientPacket.Mojang.Java.Play.CommandSuggestionsResponse.self
            case .commands:                       return ClientPacket.Mojang.Java.Play.Commands.self
            case .close_container:                return ClientPacket.Mojang.Java.Play.CloseContainer.self
            case .set_container_content:          return ClientPacket.Mojang.Java.Play.SetContainerContent.self
            case .set_container_property:         return ClientPacket.Mojang.Java.Play.SetContainerProperty.self
            case .set_container_slot:             return ClientPacket.Mojang.Java.Play.SetContainerSlot.self
            case .set_cooldown:                   return ClientPacket.Mojang.Java.Play.SetCooldown.self
            case .chat_suggestions:               return ClientPacket.Mojang.Java.Play.ChatSuggestions.self
            case .plugin_message:                 return ClientPacket.Mojang.Java.Play.PluginMessage.self
            case .damage_event:                   return ClientPacket.Mojang.Java.Play.DamageEvent.self
            case .delete_message:                 return ClientPacket.Mojang.Java.Play.DeleteMessage.self
            case .disconnect:                     return ClientPacket.Mojang.Java.Play.Disconnect.self
            case .disguised_chat_message:         return ClientPacket.Mojang.Java.Play.DisguisedChatMessage.self
            case .entity_event:                   return ClientPacket.Mojang.Java.Play.EntityEvent.self
            case .explosion:                      return ClientPacket.Mojang.Java.Play.Explosion.self
            case .unload_chunk:                   return ClientPacket.Mojang.Java.Play.UnloadChunk.self
            case .game_event:                     return ClientPacket.Mojang.Java.Play.GameEvent.self
            case .open_horse_screen:              return ClientPacket.Mojang.Java.Play.OpenHorseScreen.self
            case .hurt_animation:                 return ClientPacket.Mojang.Java.Play.HurtAnimation.self
            case .initialize_world_border:        return ClientPacket.Mojang.Java.Play.InitializeWorldBorder.self
            case .keep_alive:                     return ClientPacket.Mojang.Java.Play.KeepAlive.self
                
            case .ping:                           return ClientPacket.Mojang.Java.Play.Ping.self
            case .place_ghost_recipe:             return ClientPacket.Mojang.Java.Play.PlaceGhostRecipe.self
            case .player_abilities:               return ClientPacket.Mojang.Java.Play.PlayerAbilities.self
            case .player_chat_message:            return ClientPacket.Mojang.Java.Play.PlayerChatMessage.self
                
            case .server_data:                    return ClientPacket.Mojang.Java.Play.ServerData.self
            case .set_action_bar_text:            return ClientPacket.Mojang.Java.Play.SetActionBarText.self
            case .set_border_center:              return ClientPacket.Mojang.Java.Play.SetBorderCenter.self
            case .set_border_lerp_size:           return ClientPacket.Mojang.Java.Play.SetBorderLerpSize.self
            case .set_border_size:                return ClientPacket.Mojang.Java.Play.SetBorderSize.self
            case .set_border_warning_delay:       return ClientPacket.Mojang.Java.Play.SetBorderWarningDelay.self
            case .set_border_warning_distance:    return ClientPacket.Mojang.Java.Play.SetBorderWarningDistance.self
            case .set_camera:                     return ClientPacket.Mojang.Java.Play.SetCamera.self
            case .set_held_item:                  return ClientPacket.Mojang.Java.Play.SetHeldItem.self
            case .set_center_chunk:               return ClientPacket.Mojang.Java.Play.SetCenterChunk.self
            case .set_render_distance:            return ClientPacket.Mojang.Java.Play.SetRenderDistance.self
            case .set_default_spawn_position:     return ClientPacket.Mojang.Java.Play.SetDefaultSpawnPosition.self
            case .display_objective:              return ClientPacket.Mojang.Java.Play.DisplayObjective.self
                
            case .link_entities:                  return ClientPacket.Mojang.Java.Play.LinkEntities.self
            case .set_entity_velocity:            return ClientPacket.Mojang.Java.Play.SetEntityVelocity.self
                
            case .set_experience:                 return ClientPacket.Mojang.Java.Play.SetExperience.self
            case .set_health:                     return ClientPacket.Mojang.Java.Play.SetHealth.self
                
            case .set_passengers:                 return ClientPacket.Mojang.Java.Play.SetPassengers.self
            case .update_teams:                   return ClientPacket.Mojang.Java.Play.UpdateTeams.self
            case .update_score:                   return ClientPacket.Mojang.Java.Play.UpdateScore.self
            case .set_simulation_distance:        return ClientPacket.Mojang.Java.Play.SetSimulationDistance.self
            case .set_subtitle_text:              return ClientPacket.Mojang.Java.Play.SetSubtitleText.self
            case .update_time:                    return ClientPacket.Mojang.Java.Play.UpdateTime.self
            case .set_title_text:                 return ClientPacket.Mojang.Java.Play.SetTitleText.self
            case .set_title_animation_times:      return ClientPacket.Mojang.Java.Play.SetTitleAnimationTimes.self
            case .entity_sound_effect:            return ClientPacket.Mojang.Java.Play.EntitySoundEffect.self
            case .sound_effect:                   return ClientPacket.Mojang.Java.Play.SoundEffect.self
            case .stop_sound:                     return ClientPacket.Mojang.Java.Play.StopSound.self
            case .system_chat_message:            return ClientPacket.Mojang.Java.Play.SystemChatMessage.self
            case .set_tab_list_header_and_footer: return ClientPacket.Mojang.Java.Play.SetTabListHeaderAndFooter.self
            case .tag_query_response:             return ClientPacket.Mojang.Java.Play.TagQueryResponse.self
            case .pickup_item:                    return ClientPacket.Mojang.Java.Play.PickupItem.self
            case .teleport_entity:                return ClientPacket.Mojang.Java.Play.TeleportEntity.self
                
            case .feature_flags:                  return ClientPacket.Mojang.Java.Play.FeatureFlags.self
                
            case .update_recipes:                 return ClientPacket.Mojang.Java.Play.UpdateRecipes.self
            case .update_tags:                    return ClientPacket.Mojang.Java.Play.UpdateTags.self
            default:
                return nil
            }
        }
    }
}
