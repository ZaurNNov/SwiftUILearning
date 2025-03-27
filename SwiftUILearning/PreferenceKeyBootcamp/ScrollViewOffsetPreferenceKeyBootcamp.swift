//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 27.03.2025.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        defaultValue = nextValue()
    }
}

extension View {
    
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader(content: { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                })
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
//                scrollViewOffset = value
                action(value)
            }
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "This is scoll view!"
    @State private var scrollViewOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63)
//                    .background(
//                        GeometryReader(content: { geo in
//                            Text("")
//                                .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
//                        })
//                    )
                    .onScrollViewOffsetChanged { offset in
                        scrollViewOffset = offset
                    }
                
                contentLayer
            }
            .padding()
        }
        .overlay(content: {
            Text("ScrollViewOffset: \(scrollViewOffset)")
        })
//        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
//            scrollViewOffset = value
//        }
        .overlay(
            navBarLayer
                .opacity(Double(scrollViewOffset) / -63), alignment: .top
//            .opacity(scrollViewOffset < 1 ? 1 : 0), alignment: .top
        )
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<20) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.pink).opacity(0.3)
                .frame(width: 300, height: 150)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue).opacity(0.8)
    }
}
