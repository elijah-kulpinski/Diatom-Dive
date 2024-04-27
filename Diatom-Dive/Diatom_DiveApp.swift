//
//  Diatom_DiveApp.swift
//  Diatom-Dive
//
//  Created by Eli Kulpinski on 3/28/24.
//

import SwiftUI
import Firebase

@main
struct Diatom_DiveApp: App {
    // Initialize Firebase in the application
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            StartupView() // Application Entry Point
        }
    }
}
