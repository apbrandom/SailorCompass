//
//  CatalogIcon.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//

import Foundation

struct CatalogIcon {
    let icon: String
    let title: String
    
    static let myTest = CatalogIcon(icon: "memorychip", title: "Saved Tests")
    static let publicTest = CatalogIcon(icon: "folder", title: "Tests to Public Library")
    static let publicQuestion = CatalogIcon(icon: "books.vertical", title: "Global Maritime Community Questions Hub")
    static let quiz = CatalogIcon(icon: "figure.strengthtraining.traditional", title: "Test practice")
}
