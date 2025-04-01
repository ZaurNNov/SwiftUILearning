//
//  CustomNavBarView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct CustomNavBarView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton
                .opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundStyle(.white)
        .font(.headline)
        .background(
            Color.blue
                .ignoresSafeArea(edges: .top)
                .opacity(0.4)
        )
    }
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

#Preview {
    CustomNavBarView(showBackButton: true, title: "uytf", subtitle: "ytufgyuh")
    Spacer()
}
