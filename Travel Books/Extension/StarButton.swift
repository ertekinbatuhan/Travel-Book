//
//  StarButton.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import Foundation
import SwiftUI

extension Button {
    func starButtonStyle(filled: Bool) -> some View {
        self
            .foregroundColor(filled ? .yellow : .gray)
            .font(.system(size: 20))
            .buttonStyle(BorderlessButtonStyle())
    }
}
