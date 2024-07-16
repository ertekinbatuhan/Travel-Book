//
//  StarRatingView.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import Foundation
import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Button(action: {
                    rating = index
                }) {
                    Image(systemName: index <= rating ? "star.fill" : "star")
                }
                .starButtonStyle(filled: index <= rating)
            }
        }
    }
}
