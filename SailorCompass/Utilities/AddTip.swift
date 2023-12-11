//
//  TipKit.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 11.12.2023.
//

import TipKit

struct AddTestTip: Tip {
    
    @available(iOS 16, *)
    
    var id: String {
        UUID().uuidString
    }
    
    var title: Text {
        Text("Tap here")
    }
    
    var message: Text? {
        Text("Здесь вы можете посомотреть, хранить и создать свои тесты")
    }
    
    var image: Image? {
        Image(systemName: "list.bullet.rectangle")
    }
}

@available(iOS 17, *)
func configureTipsIfAvailable() {
    do {
        try Tips.configure([
            .datastoreLocation(.applicationDefault)
        ])
    } catch {
        // Обработка ошибок конфигурации Tips
    }
}

