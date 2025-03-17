//
//  ViewModifiedBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 14.03.2025.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(height: 55)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
//            .padding()
    }
}

extension View {
    
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        self
            .modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifiedBootcamp: View {
    var body: some View {
        
        
        VStack(spacing: 24) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.headline)
                .withDefaultButtonFormatting(backgroundColor: .blue)
                        
            Text("yyrrty other")
                .withDefaultButtonFormatting(backgroundColor: .gray)

            Text("Hello")
                .withDefaultButtonFormatting(backgroundColor: .orange)
        }
        .padding()
    }
}

#Preview {
    ViewModifiedBootcamp()
}
