//
//  AnimatableDataBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 26.03.2025.
//

import SwiftUI

struct AnimatableDataBootcamp: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: animate ? 250/2 : 0)
//                .frame(width: 250, height: 250)
            // RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
            Pacman(offsetAmount: animate ? 20 : 0)
                .frame(width: 300, height: 300)
            
        }
        .onAppear {
            withAnimation(Animation.easeInOut.repeatForever()) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    AnimatableDataBootcamp()
}

struct RectangleWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat // = 60
    
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            // corner
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxX - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}


struct Pacman: Shape {
    
    var offsetAmount: Double
    
    var animatableData: Double {
        get {
            offsetAmount
        }
        set {
            offsetAmount = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: offsetAmount),
                endAngle: Angle(degrees: -offsetAmount),
                clockwise: false)
        }
    }
}
