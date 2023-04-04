//
//  macOS_EsayAIApp.swift
//  macOS-EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI

@main
struct macOS_EsayAIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
