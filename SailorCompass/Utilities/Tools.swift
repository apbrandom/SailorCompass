//
//  Tools.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.11.2023.
//

import Foundation

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
