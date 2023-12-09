//
//  SailorCompassApp.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

@main
struct SailorCompassApp: App {
    let persistenceController = CoreDataController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .accentColor(Color("PrimaryTextColor"))
                
        }
    }
}
