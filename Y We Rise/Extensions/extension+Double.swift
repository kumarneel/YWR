//
//  extension+Double.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation

extension Int {
    func getBirthdayFromTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let date = Date(timeIntervalSince1970: Double(self))
        return formatter.string(from: date)
    }
}
