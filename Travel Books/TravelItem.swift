//
//  TravelItem.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import Foundation

struct TravelItem : Codable , Identifiable{
    var id = UUID()
    var title: String
    var description: String
    var imageData: Data?
    var rating: Int
}
