//
//  reMindSwiftDataApp.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 08/03/24.
//

import SwiftUI
import SwiftData

@main
struct reMindSwiftDataApp: App {
    @StateObject var boxesVM = BoxesViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Box.self/*Item.self*/])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            BoxesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
