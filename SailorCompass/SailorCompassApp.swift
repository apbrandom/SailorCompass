//
//  SailorCompassApp.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI
import TipKit

@main
struct SailorCompassApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .accentColor(Color("PrimaryTextColor"))
                .task {
                    if #available(iOS 17, *) {
                        configureTipsIfAvailable()
                    } 
                }
        }
    }
}
