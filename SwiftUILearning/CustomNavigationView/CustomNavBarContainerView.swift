//
//  CustomNavBarContainerView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = "" // ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNabBarTitlePreferenceKey.self) { value in
            title = value
        }
        .onPreferenceChange(CustomNabBarSubTitlePreferenceKey.self) { value in
            subtitle = value
        }
        .onPreferenceChange(CustomNabBarBackButtonHidenPreferenceKey.self) { value in
            showBackButton = !value
        }
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.gray.ignoresSafeArea()
            Text("Hello world!")
                .foregroundStyle(.white)
                .font(.headline)
                .customNavTitle("hi title")
                .customNavSubTitle("this subtitle")
        }
    }
}
