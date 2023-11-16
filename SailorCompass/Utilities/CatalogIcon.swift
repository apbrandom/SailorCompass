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
    
    static let myTest = CatalogIcon(icon: "folder.badge.person.crop", title: "My Tests")
    static let publicTest = CatalogIcon(icon: "folder", title: "Public Tests")
    static let publicQuestion = CatalogCell(icon: "folder.badge.questionmark", title: "Public Questions")
}
