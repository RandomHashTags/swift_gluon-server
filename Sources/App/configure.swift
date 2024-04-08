//
//  configure.swift
//
//
//  Created by Evan Anderson on 2/3/23.
//

import Vapor
//import HugeNumbers

/*
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
    
    app.http.server.configuration.hostname = "192.168.1.96"
    app.http.server.configuration.port = 25565
    //app.http.server.configuration.serverName = Settings.get_server_name()
    //app.http.server.configuration.supportVersions = [.one]
    
    //test()
    start_server(app)
}

private func test() {
    let difficulty:any Difficulty = DifficultyJava(id: "minecraft.normal", name: "Normal", damage_multiplier: 1)
    let world:GluonWorld = GluonWorld.init(
        uuid: UUID(),
        seed: 420,
        name: "minecraft.overworld",
        spawn_location: Vector.init(x: HugeFloat.zero, y: HugeFloat.zero, z: HugeFloat.zero),
        difficulty: difficulty,
        game_rules: [],
        time: 0,
        y_min: HugeFloat("-64"),
        y_max: HugeFloat("365"),
        y_sea_level: HugeFloat.zero,
        chunks_loaded: [],
        allows_animals: true,
        allows_monsters: true,
        allows_pvp: true,
        beds_work: true,
        entities: [],
        living_entities: [],
        players: []
    )
    let chunk:any Chunk = GluonChunk.init(world: world, x: HugeInt.zero, z: HugeInt.zero)
    BlockPopulator.populate(chunk: chunk)
}

private func start_server(_ app: Application) {
    // TODO: support (gluon server implementation below)

    /*app.webSocket("**") { request, server_socket in
        print("test1")
        
        server_socket.onText { client_socket, text in
            print("test2")
        }
        server_socket.onPing { client_socket in
            print("test3")
        }
        server_socket.onPong { client_socket in
            print("test4")
        }
        
        server_socket.onBinary { client_socket, buffer in
            print("test5")
        }
    }*/
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
    
    return;
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
        let server:GluonServer = GluonServer.shared
        server.player_joined()
    }
}
*/
func get_localized_string(key: String, table: String) -> String {
    let value:String.LocalizationValue = String.LocalizationValue(stringLiteral: key)
    return String(localized: value, table: table, bundle: Bundle.module)
}
