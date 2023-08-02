//
//  ChatPacketMojang.swift
//  
//
//  Created by Evan Anderson on 8/2/23.
//

import Foundation

public struct ChatPacketMojang : ChatPacket {
    let text:String
    let bold:Bool?
    let italic:Bool?
    let underlined:Bool?
    let strikethrough:Bool?
    let obfuscated:Bool?
    let font:String?
    let color:String?
    let insertion:String?
    let clickEvent:ChatPacketMojang.ClickEvent?
    let hoverEvent:ChatPacketMojang.HoverEvent?
    
    let extra:[ChatPacketMojang]?
    
    public var platform : PacketPlatform {
        return PacketPlatform.mojang
    }
}

public extension ChatPacketMojang {
    /// Defines an event that occurs when this component is clicked. Contains an `action` key and a `value` key. `value` is internally handled as a String, although it can be any type of JSON primitive.
    struct ClickEvent : Hashable, Codable {
        let action:ClickEventAction
        let value:String
    }
    enum ClickEventAction : String, Hashable, Codable {
        /// Opens the given URL in the default web browser. Ignored if the player has opted to disable links in chat; may open a GUI prompting the user if the setting for that is enabled. The link's protocol must be set and must be `http` or `https`, for security reasons.
        case open_url
        
        /// **Cannot be used within JSON chat**. Opens a link to any protocol, but cannot be used in JSON chat for security reasons. Only exists to internally implement links for screenshots.
        @available(*, deprecated, message: "No longer supported.")
        case open_file
        
        /// Runs the given command. Not required to be a command - clicking this only causes the client to send the given content as a chat message, so if not prefixed with `/`, they will say the given text instead. If used in a book GUI, the GUI is closed after clicking.
        case run_command
        
        /// Cannot be used within JSON chat. Only usable in 1.8 and below; twitch support was removed in 1.9. Additionally, this is only used internally by the client. On click, opens a twitch user info GUI screen. Value should be the twitch user name.
        @available(*, deprecated, message: "No longer supported.")
        case twitch_user_info
        
        /// Only usable for messages in chat. Replaces the content of the chat box with the given text - usually a command, but it is not required to be a command (commands should be prefixed with `/`).
        case suggested_command
        
        /// Only usable within written books. Changes the page of the book to the given page, starting at 1. For instance, `"value":1` switches the book to the first page. If the page is less than one or beyond the number of pages in the book, the event is ignored.
        case change_page
        
        /// Copies the given text to the client's clipboard when clicked.
        case copy_to_clipboard
    }
}

public extension ChatPacketMojang {
    /// Defines an event that occurs when this component hovered over. Contains an `action` key and a `contents key`; `action` is a String and `contents` is a JSON object. However, since text components can be serialized as primitives as well as arrays and objects, this can directly be a String
    struct HoverEvent : Hashable, Codable {
        let action:HoverEventAction
        let contents:String // TODO: fix (make codable)
    }
    enum HoverEventAction : String, Hashable, Codable {
        /// The text to display. Can either be a string directly ("contents":"la") or a full component (`"contents":{"text":"la","color":"red"}`). Note that versions prior to 1.16 use the `value` field instead of `contents` but value is still supported.
        case show_text
        
        /// The NBT of the item to display expressed as a JSON Object containing the keys `id`, `count` and `tag`. `id` is a resource location to the item for (`minecraft:stone`). `count` is the number of items in the item stack. `tag` is a string of the items nbt information in the form of sNBT (as would be used in `/give`). Example: `"contents":{"id":"minecraft:lime_wool","count": 2,"tag":"{display:{Name:Testing}}"}`. Invalid Items are replaced by `minecraft:air`
        /// Note that in versions before 1.16 this is a String and not a JSON object - it should either be set in a String directly (`"value":"{id:35,Damage:5,Count:2,tag:{display:{Name:Testing}}}"`) or as text of a component (`"value":{"text":"{id:35,Damage:5,Count:2,tag:{display:{Name:Testing}}}"`}). If the item is invalid, "Invalid Item!" will be drawn in red instead.
        case show_item
        
        /// A JSON-NBT String describing the entity. Contains 3 values: `id`, the entity's UUID (with dashes); `type` (optional), which contains the resource location for the entity's type (eg `minecraft:zombie`); and `name`, which contains the entity's custom name (if present). Note that this is a String and not a JSON object. It should be set in a String directly (`"value":"{id:7e4a61cc-83fa-4441-a299-bf69786e610a,type:minecraft:zombie,name:Zombie}"`) or as the content of a component. If the entity is invalid, "Invalid Entity!" will be displayed. Note that the client does _not_ need to have the given entity loaded.
        case show_entity
        
        /// Since 1.12, this no longer exists; advancements instead simply use show\_text. The ID of an achievement or statistic to display. Example: `"contents":{"translate":"achievement.openInventory"}` (1.16+) and `"value":"achievement.openInventory"` (prior to 1.16).
        @available(*, deprecated, message: "No longer supported.")
        case show_achievement
    }
}
