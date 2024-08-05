//
//  EatWell_V2App.swift
//  EatWell_V2
//
//  Created by Shilin Li on 24/05/2024.
//

import SwiftUI

@main
struct EatWell_V2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
            WindowGroup {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
