import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TravelViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.travelItems.indices, id: \.self) { index in
                    let item = viewModel.travelItems[index]
                    
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
                            Text(item.title)
                                .font(.title2.bold())
                                .foregroundColor(.purple)
                                .offset(x : 10)
                            
                            Spacer()
                            
                            StarRatingView(rating: .constant(item.rating))
                                .offset(x : -10)
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
                            viewModel.deleteTravelItem(at: IndexSet([index]))
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
                .onAppear {
                    viewModel.loadTravelItems()
                }
            }
            .navigationTitle("Travel Books")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

