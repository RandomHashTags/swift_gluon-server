//
//  ClientMojangPacketGameplayID.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum ClientMojangPacketGameplayID : UInt, ClientPacketGameplayID { // https://wiki.vg/Protocol
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
    case clear_titles
    case command_suggestions_response
    case commands
    case clone_container
    case set_container_content
    case set_container_property
    case set_container_slot
    case set_cooldown
    case chat_suggestions
    case plugin_message
    case delete_message
    case disconnect
    case disguised_chat_message
    case entity_event
    case explosion
    case unload_chunk
    case game_event
    case open_horse_screen
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
    
    public func decode<T>(data: Data) -> T? {
        switch self {
        default:
            return nil
        }
    }
}
