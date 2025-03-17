//
//  CustomShapesBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 17.03.2025.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}


struct CustomShapesBootcamp: View {
    var body: some View {
        ZStack{
//            Image("LoveOwl")
//                .resizable()
//                .scaledToFill()
//            Triangle()
//                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [12]))
//                .foregroundColor(.blue)
//                .fill(.linearGradient(Gradient(colors: [Color.red, Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                .trim(from: 0, to: 0.5)
//            Diamond()
            Trapezoid()
                .frame(width: 300, height: 300)
//                .clipShape(
//                    Triangle()
//                        .rotation(.degrees(90))
//                )
                
        }
    }
}

#Preview {
    CustomShapesBootcamp()
}
