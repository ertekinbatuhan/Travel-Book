import Foundation
import SwiftUI

class TravelViewModel: ObservableObject {
    
    @Published var travelItems: [TravelItem] = []
    private let userDefaultsKey = "savedTravelItems"
    @Published var image: UIImage?
    @Published var travelName = ""
    @Published var travelDescription = ""
    @Published var rating = 0
    @Published var selectedDate = Date()
    @Published var isSaved = false
    
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
                print("Error decoding \(error.localizedDescription)")
            }
        }
    }
    
    func addTravelItem() {
        guard let image = image else {
            return
        }
        
        guard !travelName.isEmpty else {
            return
        }
        
        guard !travelDescription.isEmpty else {
            return
        }
        
        let newItem = TravelItem(title: travelName, description: travelDescription, imageData: image.jpegData(compressionQuality: 0.5), rating: rating, date: selectedDate)
        
        travelItems.append(newItem)
        saveTravelItems()
        isSaved = true
    }
    
    func deleteTravelItem(at offsets: IndexSet) {
        travelItems.remove(atOffsets: offsets)
        saveTravelItems()
    }
    
    private func saveTravelItems() {
        do {
            let encodedDataArray = try travelItems.map { try JSONEncoder().encode($0) }
            UserDefaults.standard.set(encodedDataArray, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
        } catch {
            print("Error encoding \(error.localizedDescription)")
        }
    }
    
    func resetFields() {
        image = nil
        travelName = ""
        travelDescription = ""
        rating = 0
        selectedDate = Date()
    }
}

