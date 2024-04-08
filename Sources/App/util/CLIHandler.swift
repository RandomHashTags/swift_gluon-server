//
//  CLIHandler.swift
//
//
//  Created by Evan Anderson on 4/8/24.
//

import Logging

enum CLIHandler {
    static func listen() {
        guard let line:String = get_input() else { return }
        if let label:Substring = line.split(separator: " ").first {
            if let command:any Command = GluonServer.shared.commands[String(label)] {
                /*Task {
                    let succeeded:Bool = await command.execute(sender: /* console sender */)
                }*/
            } else {
                ServerMojang.instance.logger.warning(Logger.Message(stringLiteral: "Unknown command: \"" + label + "\""))
            }
        }
        
        Task {
            CLIHandler.listen()
        }
    }
    static func get_input() -> String? {
        return readLine()
    }
}