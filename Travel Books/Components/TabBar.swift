//
//  TabBar.swift
//  Travel Books
//
//  Created by Batuhan Berk Ertekin on 16.07.2024.
//

import SwiftUI

import SwiftUI

struct TabBar: View {
    
    @State private var tabSelection = 1
    
    var body: some View{
        
        TabView(selection : $tabSelection){
           
            HomeView().tag(1)
            
            AddTravelView().tag(2)
            
         
        }
        
        .overlay(alignment : .bottom){
            
            CustomTabView(tabSelection: $tabSelection)
        }
    }
    
}

#Preview {
    TabBar()
}
