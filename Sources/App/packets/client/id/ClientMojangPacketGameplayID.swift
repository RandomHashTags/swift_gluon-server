//
//  ClientMojangPacketGameplayID.swift
//  
//
//  Created by Evan Anderson on 2/4/23.
//

import Foundation

public enum ClientMojangPacketGameplayID : UInt, ClientPacketGameplayID { // https://wiki.vg/Protocol
    case spawn_entity =                        0
    case spawn_experience_orb =                1
    case spawn_player =                        2
    case entity_animation =                    3
    case award_statistic =                     4
    case acknowledge_block_change =            5
    case set_block_destroy_stage =             6
    case block_entity_data =                   7
    case block_action =                        8
    case block_update =                        9
    case boss_bar =                            10
    case change_difficulty =                   11
    case clear_titles =                        12
    case command_suggestions_response =        13
    case commands =                            14
    case clone_container =                     15
    case set_container_content =               16
    case set_container_property =              17
    case set_container_slot =                  18
    case set_cooldown =                        19
    case chat_suggestions =                    20
    case plugin_message =                      21
    case delete_message =                      22
    case disconnect =                          23
    case disguised_chat_message =              24
    case entity_event =                        25
    case explosion =                           26
    case unload_chunk =                        27
    case game_event =                          28
    case open_horse_screen =                   29
    case initialize_world_border =             30
    case keep_alive =                          31
    case chunk_daa_and_update_light =          32
    case world_event =                         33
    case particle =                            34
    case update_light =                        35
    case login =                               36
    case map_data =                            37
    case merchant_offers =                     38
    case update_entity_position =              39
    case update_entity_position_and_rotation = 40
    case update_entity_rotation =              41
    case move_vehicle =                        42
    case open_book =                           43
    case open_screen =                         44
    case open_sign_editor =                    45
    case ping =                                46
    case place_ghost_recipe =                  47
    case player_abilities =                    48
    case player_chat_message =                 49
    case end_combat =                          50
    case enter_combat =                        51
    case combat_death =                        52
    case player_info_remove =                  53
    case player_info_update =                  54
    case look_at =                             55
    case synchronize_player_position =         56
    case update_recipe_book =                  57
    case remove_entities =                     58
    case remote_entity_effect =                59
    case resource_pack =                       60
    case respawn =                             61
    case set_head_rotation =                   62
    case update_section_blocks =               63
    case select_advancements_tab =             64
    case server_data =                         65
    case set_action_bar_text =                 66
    case set_border_center =                   67
    case set_border_lerp_size =                68
    case set_border_size =                     69
    case set_border_warning_delay =            70
    case set_camera =                          71
    case set_held_item =                       72
    case set_center_chunk =                    73
    case set_render_distance =                 74
    case set_default_spawn_position =          75
    case display_objective =                   76
    case set_entity_metadata =                 77
    case link_entities =                       78
    case set_entity_velocity =                 79
    case set_equipment =                       80
    case set_experience =                      81
    case set_health =                          82
    case update_objectives =                   83
    case set_passengers =                      84
    case update_teams =                        85
    case update_score =                        86
    case set_simulation_distance =             87
    case set_subtitle_text =                   88
    case update_time =                         89
    case set_title_text =                      90
    case set_title_animation_times =           91
    case entity_sound_effect =                 92
    case sound_effect =                        93
    case stop_sound =                          94
    case system_chat_message =                 95
    case set_tab_list_header_and_footer =      96
    case tag_query_response =                  97
    case pickup_item =                         98
    case teleport_entity =                     99
    case update_advancements =                 100
    case update_attributes =                   101
    case feature_flags =                       102
    case entity_effect =                       103
    case update_recipes =                      104
    case update_tags =                         105
    
    public func decode<T>(data: Data) -> T? {
        switch self {
        default:
            return nil
        }
    }
}
