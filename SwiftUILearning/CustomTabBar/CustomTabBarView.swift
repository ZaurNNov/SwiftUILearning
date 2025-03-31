//
//  CustomTabBarView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Namespace private var namespase
    let tabs: [TabBarItem]
    @State var localSelection: TabBarItem
    @Binding var selection: TabBarItem
    //= .init(iconName: "house", title: "Home", color: .red)
    
    var body: some View {
//        tabBarVersion1
        tabBarVersion2
//            .onChange(of: selection) { newValue in
//                withAnimation(.easeInOut) {
//                    localSelection = newValue
//                }
//            }
            .onChange(of: selection) { _, newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.color : .gray.opacity(0.9))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.2) : .clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(8)
        .background(
            Color.white.opacity(0.25).ignoresSafeArea(edges: .bottom)
        )
    }
    
    private func switchToTab(tab: TabBarItem) {
//        withAnimation(.easeInOut) {
            selection = tab
//        }
    }
}

extension CustomTabBarView {
    
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .bold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : .gray.opacity(0.9))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "bakgrount__rectange_color", in: namespase.self)
                }
            }
            //selection == tab ? tab.color.opacity(0.2) : .clear
        )
        //.cornerRadius(10)
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(8)
        .background(
            Color.white.ignoresSafeArea(edges: .bottom)
        )
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

#Preview {
    
    let tabs: [TabBarItem] = [.home, .music, .profile]
    
    VStack {
        Spacer()
        CustomTabBarView(tabs: tabs, localSelection: tabs.first!, selection: .constant(tabs.first!))
    }
}
