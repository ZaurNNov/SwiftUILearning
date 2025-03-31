//
//  AppTapBarView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

// need:
// Generics
// ViewBuider
// PreferenceKey
// MatchedGeometryEffect

struct AppTapBarView: View {
    
    @State var selection: String = "home"
    @State var tabSelection: TabBarItem = .home

    var body: some View {
        // defaultTabBarView
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red.opacity(0.8)
                .tabBarItem(.home, selection: $tabSelection)
            
            Color.purple.opacity(0.8)
                .tabBarItem(.music, selection: $tabSelection)
            
            Color.green.opacity(0.8)
                .tabBarItem(.profile, selection: $tabSelection)
        }
    }
}

extension AppTapBarView {
    
    private var defaultTabBarView: some View {
        TabView(selection: $selection) {
            Color.blue
                .tabItem {
                    Text("home")
                    Image(systemName: "house")
                }
            
            Color.red
                .tabItem {
                    Text("favorite")
                    Image(systemName: "heart")
                }
            
            Color.orange
                .tabItem {
                    Text("profile")
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    AppTapBarView()
}
