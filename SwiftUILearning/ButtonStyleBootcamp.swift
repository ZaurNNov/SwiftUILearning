//
//  ButtonStyleBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 17.03.2025.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    init(scaleAmount: CGFloat = 0.9) {
        self.scaleAmount = scaleAmount
    }
    
    let scaleAmount: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

extension View {
    
    func withPressebleStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Tap me!")
                .font(.headline)
                .withDefaultButtonFormatting()
        }
        .padding(40)
        .withPressebleStyle(scaledAmount: 0.9)
//        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    ButtonStyleBootcamp()
}
