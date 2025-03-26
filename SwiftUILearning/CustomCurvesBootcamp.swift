//
//  CustomCurvesBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 25.03.2025.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        
        let waterGrad = LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        let gg = Gradient(colors: [Color.blue, Color.cyan])
        
        WaterShape()
            .fill((gg).opacity(0.5))
            .fill((Color.blue).opacity(0.5))
//            .fill(
//                waterGrad
//            )
            .frame(width: 300, height: 300)
//            .ignoresSafeArea()
        
        let strokeStyle = StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round, miterLimit: .infinity)
        let gradient = Gradient(colors: [Color.red, .pink, .red, .yellow])
        /*
        ArcSample()
            .stroke(.green, style: strokeStyle, antialiased: true)
            .frame(width: 300, height: 300)
        
        ShapeWithArc()
            //.stroke(.green, style: strokeStyle, antialiased: true)
            .frame(width: 300, height: 300)
            .rotationEffect(Angle(degrees: 90))
        */
        
    }
}

#Preview {
    CustomCurvesBootcamp()
}

struct ArcSample: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            //path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 125),
                endAngle: Angle(degrees: 55),
                clockwise: false)
        }
    }
}

struct ShapeWithArc: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // bottom
            //path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false)
            
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct QuadShape: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 60, y: rect.minY - 20))
        }
    }
}


struct WaterShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.4))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}
