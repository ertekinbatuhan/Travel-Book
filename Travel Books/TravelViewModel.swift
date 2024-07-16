//
//  TravelViewModel.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import Foundation
import SwiftUI

class TravelViewModel: ObservableObject {
    @Published var travelItems: [TravelItem] = []

    init() {
        loadTravelItems()
    }

    func loadTravelItems() {
        if let savedItemsData = UserDefaults.standard.array(forKey: "savedTravelItems") as? [Data] {
            do {
                travelItems = try savedItemsData.map { data in
                    try JSONDecoder().decode(TravelItem.self, from: data)
                }
            } catch {
                print("Error decoding TravelItem: \(error.localizedDescription)")
            }
        }
    }

    func deleteTravelItem(at offsets: IndexSet) {
        travelItems.remove(atOffsets: offsets)
        saveTravelItems()
    }

    func saveTravelItems() {
        do {
            let encodedDataArray = try travelItems.map { try JSONEncoder().encode($0) }
            UserDefaults.standard.set(encodedDataArray, forKey: "savedTravelItems")
        } catch {
            print("Error encoding TravelItem: \(error.localizedDescription)")
        }
    }
}
