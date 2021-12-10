//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import Firebase

@main
struct NewsAppApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Base()
        }
    }
}
