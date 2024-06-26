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
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Box.self, Term.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            BoxesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
