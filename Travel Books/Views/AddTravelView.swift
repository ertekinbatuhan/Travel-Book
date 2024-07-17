import SwiftUI
import PhotosUI

struct AddTravelView: View {
    
    @StateObject private var viewModel = TravelViewModel()
    @State private var photosPickerItem: PhotosPickerItem?
  
    var body: some View {
        NavigationStack {
            ScrollView {
                GeometryReader { geometry in
                    VStack(spacing: 20) {
                        PhotosPicker(selection: $photosPickerItem, matching: .any(of: [.images, .videos, .screenshots])) {
                            if let image = viewModel.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: geometry.size.width , maxHeight: geometry.size.width * 0.60)
                                    .cornerRadius(12.0)
                                    .shadow(radius: 10)
                                    
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .foregroundColor(.gray)
                                    .cornerRadius(12.0)
                                    .shadow(radius: 10)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        TextField("Enter Travel Name", text: $viewModel.travelName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8.0)
                            .foregroundColor(.blue)

                        TextField("Enter Travel Description", text: $viewModel.travelDescription)
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(12)
                            .foregroundColor(.blue)
                            .lineLimit(nil)
                            .tint(Color.yellow)

                        VStack(spacing: 20) {
                            HStack {
                                Text("Your Rating")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                Spacer()
                                StarRatingView(rating: $viewModel.rating)
                            }
                            .padding(.horizontal)

                            HStack {
                                Text("Select Date")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                Spacer()
                                DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                            .padding(.horizontal)
                        }

                        Button("Save") {
                            viewModel.addTravelItem()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                    .padding()
                    .onChange(of: photosPickerItem) { _ in
                        Task {
                            if let photosPickerItem = photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self),
                               let newImage = UIImage(data: data) {
                                viewModel.image = newImage
                            }
                            photosPickerItem = nil
                        }
                    }
                    .alert(isPresented: $viewModel.isSaved) {
                        Alert(title: Text("Saved"), message: Text("Travel item saved successfully."), dismissButton: .default(Text("OK"), action: viewModel.resetFields))
                    }
                    .navigationTitle("Add New Travel")
                .navigationBarTitleDisplayMode(.large)
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddTravelView()
    }
}

