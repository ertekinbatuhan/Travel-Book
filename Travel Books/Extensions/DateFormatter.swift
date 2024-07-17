//
//  DateFormatter.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 17.07.2024.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
