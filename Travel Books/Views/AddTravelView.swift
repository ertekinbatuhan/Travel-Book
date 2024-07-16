import SwiftUI
import PhotosUI

struct AddTravelView: View {
    @State private var image: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var travelName = ""
    @State private var travelDescription = ""
    @State private var rating = 0
    @State private var isSaved = false
    @State private var rooter = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    PhotosPicker(selection: $photosPickerItem, matching: .any(of: [.images, .videos, .screenshots])) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 250)
                                .cornerRadius(10.0)
                                .shadow(radius: 10)
                                .padding(.horizontal, 20)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .foregroundColor(.gray)
                                .cornerRadius(10.0)
                                .shadow(radius: 10)
                                .padding(.horizontal, 20)
                        }
                    }

                    TextField("Enter Travel Name", text: $travelName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                    
                    TextEditor(text: $travelDescription)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(12)
                            .foregroundColor(.blue)
                            .tint(Color.yellow)
                    
                    HStack(spacing: 20) {
                        Text("Your Rating : ")
                            .font(.title3)
                            .foregroundColor(.gray)
                                
                        StarRatingView(rating: $rating)
                    }
                    .padding(.horizontal)
                    
                    Button("Save") {
                        saveTravelItem()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8.0)
                    .padding(.horizontal)
                    .onChange(of: isSaved) { newValue in
                        if newValue {
                            rooter = true
                        }
                    }
                    .background(NavigationLink(destination: HomeView(), isActive: $rooter) { EmptyView() })
                }
                .padding(.horizontal)
                .onChange(of: photosPickerItem) { _ in
                    Task {
                        if let photosPickerItem = photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self),
                           let newImage = UIImage(data: data) {
                            self.image = newImage
                        }
                        photosPickerItem = nil
                    }
                }
                .alert(isPresented: $isSaved) {
                    Alert(title: Text("Saved"), message: Text("Travel item saved successfully."), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
            .navigationTitle("Add New Travel")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func saveTravelItem() {
        let newItem = TravelItem(title: travelName, description: travelDescription, imageData: image?.jpegData(compressionQuality: 0.5), rating: rating)
        
        do {
            let encodedData = try JSONEncoder().encode(newItem)
            var savedItems = UserDefaults.standard.array(forKey: "savedTravelItems") as? [Data] ?? []
            savedItems.append(encodedData)
            UserDefaults.standard.set(savedItems, forKey: "savedTravelItems")
            isSaved = true
        } catch {
            print("Error encoding \(error.localizedDescription)")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddTravelView()
    }
}

