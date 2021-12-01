//
//  Recipe_List_App.swift
//  Recipe List app
//
//  Created by Nemanja Velimirovic  on 2021-09-16.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
