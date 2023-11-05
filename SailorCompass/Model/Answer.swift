//
//  Answer.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 05.11.2023.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: String
    var isCorrect: Bool
}
