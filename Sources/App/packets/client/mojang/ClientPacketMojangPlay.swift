//
//  ClientPacketMojangPlay.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum ClientPacketMojangPlay : UInt8, PacketGameplayID { // https://wiki.vg/Protocol
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
    
    public var packet : (any ClientPacketMojangProtocol.Type)? {
        switch self {
        case .spawn_entity:                   return ClientPacketMojang.Play.SpawnEntity.self
        case .spawn_experience_orb:           return ClientPacketMojang.Play.SpawnExperienceOrb.self
        case .spawn_player:                   return ClientPacketMojang.Play.SpawnPlayer.self
        case .entity_animation:               return ClientPacketMojang.Play.EntityAnimation.self
        case .award_statistic:                return ClientPacketMojang.Play.AwardStatistics.self
        case .acknowledge_block_change:       return ClientPacketMojang.Play.AcknowledgeBlockChange.self
        case .set_block_destroy_stage:        return ClientPacketMojang.Play.SetBlockDestroyStage.self
            
        case .block_action:                   return ClientPacketMojang.Play.BlockAction.self
        case .block_update:                   return ClientPacketMojang.Play.BlockUpdate.self
        case .boss_bar:                       return ClientPacketMojang.Play.BossBar.self
        case .change_difficulty:              return ClientPacketMojang.Play.ChangeDifficulty.self
        case .chunk_biomes:                   return ClientPacketMojang.Play.ChunkBiomes.self
        case .clear_titles:                   return ClientPacketMojang.Play.ClearTitles.self
        case .command_suggestions_response:   return ClientPacketMojang.Play.CommandSuggestionsResponse.self
        case .commands:                       return ClientPacketMojang.Play.Commands.self
        case .close_container:                return ClientPacketMojang.Play.CloseContainer.self
        case .set_container_content:          return ClientPacketMojang.Play.SetContainerContent.self
        case .set_container_property:         return ClientPacketMojang.Play.SetContainerProperty.self
        case .set_container_slot:             return ClientPacketMojang.Play.SetContainerSlot.self
        case .set_cooldown:                   return ClientPacketMojang.Play.SetCooldown.self
        case .chat_suggestions:               return ClientPacketMojang.Play.ChatSuggestions.self
        case .plugin_message:                 return ClientPacketMojang.Play.PluginMessage.self
        case .damage_event:                   return ClientPacketMojang.Play.DamageEvent.self
        case .delete_message:                 return ClientPacketMojang.Play.DeleteMessage.self
        case .disconnect:                     return ClientPacketMojang.Play.Disconnect.self
        case .disguised_chat_message:         return ClientPacketMojang.Play.DisguisedChatMessage.self
        case .entity_event:                   return ClientPacketMojang.Play.EntityEvent.self
        case .explosion:                      return ClientPacketMojang.Play.Explosion.self
        case .unload_chunk:                   return ClientPacketMojang.Play.UnloadChunk.self
        case .game_event:                     return ClientPacketMojang.Play.GameEvent.self
        case .open_horse_screen:              return ClientPacketMojang.Play.OpenHorseScreen.self
        case .hurt_animation:                 return ClientPacketMojang.Play.HurtAnimation.self
        case .initialize_world_border:        return ClientPacketMojang.Play.InitializeWorldBorder.self
        case .keep_alive:                     return ClientPacketMojang.Play.KeepAlive.self
            
        case .ping:                           return ClientPacketMojang.Play.Ping.self
        case .place_ghost_recipe:             return ClientPacketMojang.Play.PlaceGhostRecipe.self
        case .player_abilities:               return ClientPacketMojang.Play.PlayerAbilities.self
        case .player_chat_message:            return ClientPacketMojang.Play.PlayerChatMessage.self
            
        case .server_data:                    return ClientPacketMojang.Play.ServerData.self
        case .set_action_bar_text:            return ClientPacketMojang.Play.SetActionBarText.self
        case .set_border_center:              return ClientPacketMojang.Play.SetBorderCenter.self
        case .set_border_lerp_size:           return ClientPacketMojang.Play.SetBorderLerpSize.self
        case .set_border_size:                return ClientPacketMojang.Play.SetBorderSize.self
        case .set_border_warning_delay:       return ClientPacketMojang.Play.SetBorderWarningDelay.self
        case .set_border_warning_distance:    return ClientPacketMojang.Play.SetBorderWarningDistance.self
        case .set_camera:                     return ClientPacketMojang.Play.SetCamera.self
        case .set_held_item:                  return ClientPacketMojang.Play.SetHeldItem.self
        case .set_center_chunk:               return ClientPacketMojang.Play.SetCenterChunk.self
        case .set_render_distance:            return ClientPacketMojang.Play.SetRenderDistance.self
        case .set_default_spawn_position:     return ClientPacketMojang.Play.SetDefaultSpawnPosition.self
        case .display_objective:              return ClientPacketMojang.Play.DisplayObjective.self
            
        case .link_entities:                  return ClientPacketMojang.Play.LinkEntities.self
        case .set_entity_velocity:            return ClientPacketMojang.Play.SetEntityVelocity.self
            
        case .set_experience:                 return ClientPacketMojang.Play.SetExperience.self
        case .set_health:                     return ClientPacketMojang.Play.SetHealth.self
            
        case .set_passengers:                 return ClientPacketMojang.Play.SetPassengers.self
        case .update_teams:                   return ClientPacketMojang.Play.UpdateTeams.self
        case .update_score:                   return ClientPacketMojang.Play.UpdateScore.self
        case .set_simulation_distance:        return ClientPacketMojang.Play.SetSimulationDistance.self
        case .set_subtitle_text:              return ClientPacketMojang.Play.SetSubtitleText.self
        case .update_time:                    return ClientPacketMojang.Play.UpdateTime.self
        case .set_title_text:                 return ClientPacketMojang.Play.SetTitleText.self
        case .set_title_animation_times:      return ClientPacketMojang.Play.SetTitleAnimationTimes.self
        case .entity_sound_effect:            return ClientPacketMojang.Play.EntitySoundEffect.self
        case .sound_effect:                   return ClientPacketMojang.Play.SoundEffect.self
        case .stop_sound:                     return ClientPacketMojang.Play.StopSound.self
        case .system_chat_message:            return ClientPacketMojang.Play.SystemChatMessage.self
        case .set_tab_list_header_and_footer: return ClientPacketMojang.Play.SetTabListHeaderAndFooter.self
        case .tag_query_response:             return ClientPacketMojang.Play.TagQueryResponse.self
        case .pickup_item:                    return ClientPacketMojang.Play.PickupItem.self
        case .teleport_entity:                return ClientPacketMojang.Play.TeleportEntity.self
            
        case .feature_flags:                  return ClientPacketMojang.Play.FeatureFlags.self
            
        case .update_recipes:                 return ClientPacketMojang.Play.UpdateRecipes.self
        case .update_tags:                    return ClientPacketMojang.Play.UpdateTags.self
        default:
            return nil
        }
    }
}
