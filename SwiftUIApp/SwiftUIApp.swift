//
//  SwiftUIAppApp.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftUIApp : App {
    // Define the shared ModelContainer
    var sharedModelContainer : ModelContainer = {
        do { // Create the ModelContainer with CustomModel schema
            return try ModelContainer(for: CustomModel.self)
        } catch { // Handle any errors that occur during ModelContainer creation
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Pass the ModelContainer to the ContentView
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
