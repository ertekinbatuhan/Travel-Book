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
                travelItems = try savedItemsData.map { data in
                    try JSONDecoder().decode(TravelItem.self, from: data)
                }
            } catch {
                print("Error decoding\(error.localizedDescription)")
            }
        }
    }

    func addTravelItem(_ item: TravelItem) {
        travelItems.append(item)
        saveTravelItems()
    }

    func deleteTravelItem(at offsets: IndexSet) {
     
            self.travelItems.remove(atOffsets: offsets)
            self.saveTravelItems()
            
        }
    

    private func saveTravelItems() {
        do {
            let encodedDataArray = try travelItems.map { try JSONEncoder().encode($0) }
            UserDefaults.standard.set(encodedDataArray, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
        } catch {
            print("Error encoding\(error.localizedDescription)")
        }
    }
}

