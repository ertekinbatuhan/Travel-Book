import SwiftUI

struct TabBar: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "globe.asia.australia.fill")
                }
                
            AddTravelView()
                .tabItem {
                    Label("Add Travel", systemImage: "plus.message.fill")
                }
                
        }
    }
}



