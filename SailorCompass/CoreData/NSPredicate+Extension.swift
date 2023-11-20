//
//  NSPredicate.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import Foundation

extension NSPredicate {
    
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
    static let isCorrect = NSPredicate(format: "question == %@ AND isCorrect == true")
}
