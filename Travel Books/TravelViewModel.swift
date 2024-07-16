import Foundation
import SwiftUI

class TravelViewModel: ObservableObject {
    @Published var travelItems: [TravelItem] = []
    private let userDefaultsKey = "savedTravelItems"

    init() {
        loadTravelItems()
    }

    func loadTravelItems() {
        if let savedItemsData = UserDefaults.standard.array(forKey: userDefaultsKey) as? [Data] {
            do {
                travelItems = try savedItemsData.map { try JSONDecoder().decode(TravelItem.self, from: $0) }
            } catch {
                print("Error decoding\(error.localizedDescription)")
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
            UserDefaults.standard.set(encodedDataArray, forKey: userDefaultsKey)
        } catch {
            print("Error encoding\(error.localizedDescription)")
        }
    }
}

