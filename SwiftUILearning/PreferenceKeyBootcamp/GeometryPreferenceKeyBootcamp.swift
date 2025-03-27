//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 27.03.2025.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateGeoSize(geo.size)
//                        .overlay {
//                            Text(geo.size.debugDescription)
//                                .foregroundColor(.white)
//                        }
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
            self.rectSize = value
        }
        
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        self.defaultValue = nextValue()
    }
    
    typealias Value = CGSize

}

extension View {
    
    func updateGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}
