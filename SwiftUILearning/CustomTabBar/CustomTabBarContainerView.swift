//
//  CustomTabBarContainerView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
//        VStack {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, localSelection: selection, selection: $selection)
        }
//        }
        .onPreferenceChange(TabBarItempsPreferenceKey.self) { value in
            tabs = value
        }
    }
}

#Preview {
    
    let tabs: [TabBarItem] = [.home, .music, .profile]
    
    CustomTabBarContainerView(selection: .constant(tabs.first!)) {
        Color.red
    }
}
