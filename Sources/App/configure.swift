//
//  configure.swift
//
//
//  Created by Evan Anderson on 2/3/23.
//

import Vapor

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
    app.http.server.configuration.port = 25565
    //app.http.server.configuration.serverName = Settings.get_server_name()
    //app.http.server.configuration.supportVersions = [.one]
    
    test()
    //start_server(app)
}

private func test() {
    let difficulty:Difficulty = Difficulty.init(identifier: "minecraft.normal", name: MultilingualStrings.init(english: "Normal"))
    let world:World = World.init(
        uuid: UUID(),
        seed: 420,
        name: "minecraft.overworld",
        spawn_location: Vector.init(x: 0, y: 0, z: 0),
        difficulty: difficulty,
        game_rules: [],
        time: 0,
        y_min: -64,
        y_max: 365,
        y_sea_level: 0,
        chunks_loaded: [],
        allows_animals: true,
        allows_monsters: true,
        allows_pvp: true,
        beds_work: true
    )
    let chunk:Chunk = Chunk.init(world: world, x: 0, z: 0)
    BlockPopulator.populate(chunk: chunk)
}

private func start_server(_ app: Application) {
    app.webSocket("connection") { request, server_socket in
        
        server_socket.onText { client_socket, text in
            print("client_socket received: \(text)")
            
            try? await client_socket.send("echo - \(text)")
            try? await client_socket.close()
            client_socket.onClose.whenComplete { result in
                print("client_socket closed=" + client_socket.isClosed.description)
            }
        }
        
        server_socket.onPing { socket in
        }
        server_socket.onPong { socket in
        }
    }
    
    Task {
        let seconds_to_sleep:UInt64 = 1
        try await Task.sleep(nanoseconds: 1_000_000_000 * seconds_to_sleep)
        do {
            var headers:HTTPHeaders = HTTPHeaders()
            var configuration:WebSocketClient.Configuration = WebSocketClient.Configuration.init()
            let bro:() = try await WebSocket.connect(to: "ws://localhost:25565/connection", headers: headers, configuration: configuration, on: app.eventLoopGroup.next(), onUpgrade: ({ socket in
                print("socket=\(socket)")
                socket.send("here is some text big boy")
            }))
        } catch {
            print("encountered error while trying to `configure` app (\(error)")
        }
        let server:GluonServer = GluonServer.shared_instance
        server.player_joined()
    }
}
