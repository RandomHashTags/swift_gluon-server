//
//  main.swift
//
//
//  Created by Evan Anderson on 2/3/23.
//

import App
import Vapor
import NIO

let server:ServerMojang = ServerMojang(host: "192.168.1.96", port: 25565)
defer {
    server.shutdown()
}
try server.run()

/*
let server:ServerMojang = ServerMojang(host: "192.168.1.96", port: 25565)
let application:Application = server.application
defer { application.shutdown() }
try application.run()*/


/*var env:Environment = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app:Application = Application(env)
defer { app.shutdown() }
try configure(app)
try app.run()*/
