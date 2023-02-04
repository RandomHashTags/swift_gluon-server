//
//  configure.swift
//
//
//  Created by Evan Anderson on 2/3/23.
//

import Vapor
import ZippyJSON

public func configure(_ app: Application) throws {
    let directory:DirectoryConfiguration = app.directory
    //ParadigmUtilities.vaporApplication = app
    //ParadigmUtilities.vaporResourcesURL = URL(fileURLWithPath: directory.resourcesDirectory)
    
    //let productionMode:Bool = Settings.is_production_mode()
    /*app.middleware.use(FileMiddleware(publicDirectory: directory.publicDirectory))
    if productionMode {
        app.middleware.use(ParadigmMiddleware.InsecureMigration())
        app.middleware.use(ParadigmMiddleware.AuthenticationValidation())
    }
    app.middleware.use(ParadigmMiddleware.StatisticsRecorder())
    app.middleware.use(ParadigmMiddleware.ResponseHeadersPolicy())*/
    
    app.http.client.configuration.timeout = .init(connect: .seconds(60), read: .seconds(60))
    app.http.client.configuration.redirectConfiguration = .follow(max: 3, allowCycles: false)
    app.clients.use(.http)
    
    //app.http.server.configuration.hostname = productionMode ? Settings.get_hostname() : "localhost"
    //app.http.server.configuration.port = Settings.get_proxy_port()
    //app.http.server.configuration.serverName = Settings.get_server_name()
    //app.http.server.configuration.supportVersions = [.one]
    try load(app)
}

private func load(_ app: Application) throws {
    print("bruh")
}
