import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = TravelViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.travelItems) { item in
                    VStack(alignment: .leading) {
                        if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .cornerRadius(10.0)
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.title2.bold())
                                    .foregroundColor(.red)
                                
                                Text(item.date.formatted())
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                            .offset(x: 10)
                            
                            Spacer()
                            
                            StarRatingView(rating: .constant(item.rating))
                                .offset(x: -10)
                        }
                        
                        Text(item.description)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 1)
                            .padding(.bottom, 30)
                            .padding([.leading, .trailing], 10)
                    }
                    .background(Rectangle().foregroundColor(Color.white))
                    .cornerRadius(5.0)
                    .shadow(radius: 5)
                    .padding([.leading, .trailing])
                    .contextMenu {
                        Button(action: {
                            if let index = viewModel.travelItems.firstIndex(where: { $0.id == item.id }) {
                                viewModel.deleteTravelItem(at: IndexSet([index]))
                            }
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("My Travels")
            .onAppear {
                viewModel.loadTravelItems()
            }
        }
    }
    
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

