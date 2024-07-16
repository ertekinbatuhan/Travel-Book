//
//  TabBar.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        
        TabView{
            HomeView().tabItem {
                Label("Home",systemImage: "house")
            }
            
            AddTravelView().tabItem {
                
                Label("Add Travel",systemImage: "plus.circle.fill")
            }
        }
        
    }
}

#Preview {
    TabBar()
}
