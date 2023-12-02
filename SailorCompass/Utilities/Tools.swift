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

    static func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    }
    
    static func dateFromString(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.date(from: dateString) ?? Date()
    }
}

