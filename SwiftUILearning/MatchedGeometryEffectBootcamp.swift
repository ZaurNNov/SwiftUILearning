//
//  MatchedGeometryEffectBootcamp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 17.03.2025.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State var isClicked: Bool = false
    @Namespace var namespace
    
    var body: some View {
        VStack {
            
            if !isClicked {
                RoundedRectangle(cornerRadius: 16)
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 150, height: 150)
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 16)
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 60, height: 60)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .onTapGesture {
            withAnimation {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryEffectBootcamp2()
}

struct MatchedGeometryEffectBootcamp2: View {
    
    @State var categories: [String] = ["Home", "Travel", "Shopping"]
    @State var selected: String = ""
    @Namespace private var namespase2
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red.opacity(0.5))
                            .frame(width: 45, height: 3)
                            .matchedGeometryEffect(id: "category_bg", in: namespase2)
                            .offset(y: 10)
                    }
                    Text(category)
                        .foregroundColor(selected == category ? .red : .black)
                        .font(.title)
                        
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 50)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .scenePadding()
    }
}
