//
//  main.swift
//
//
//  Created by Evan Anderson on 2/3/23.
//

import App
import Vapor
import Backtrace

Backtrace.install()
var env:Environment = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app:Application = Application(env)
defer { app.shutdown() }
try configure(app)
try app.run()
