//
//  ViewBuilderBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 27.03.2025.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            if let description {
                Text(description)
                    .font(.subheadline)
            }
            if let iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 2)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: Alignment.leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            content
            
            RoundedRectangle(cornerRadius: 2)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: Alignment.leading)
        .padding()
    }
}

struct CustomHStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {

        VStack {
            HeaderViewRegular(title: "Hello", description: "Description", iconName: "heart.fill")
            
            HeaderViewRegular(title: "Another Hello", description: nil, iconName: nil)
            
//            HeaderViewGeneric(title: "GenericView Title 1", content: Text("Hello"))
//
//            HeaderViewGeneric(title: "GenericView Title 2", content: Image(systemName: "heart.fill"))
//
//            HeaderViewGeneric(title: "GenericView Title 3", content:
//                                HStack {
//                Text("Hello")
//                Image(systemName: "bolt.fill")
//                
//            }
            
            HeaderViewGeneric(title: "news") {
                HStack {
                    Text("Hello")
                    Image(systemName: "bolt.fill")
                }
            }
            
            CustomHStack {
                Text("Hello")
                Image(systemName: "bolt.fill")
            }
            
            HStack {
                Text("Hello")
                Image(systemName: "bolt.fill")
            }
            
            
            Spacer()
            
        }
    }
}

#Preview {
    LocalViewBuilder(typeV: .two)
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one
        case two
        case three
    }
    
    let typeV: ViewType
    
    var body: some View {
//        VStack {
            headerSection
//        }
    }
    
    @ViewBuilder private var headerSection: some View {
//        VStack {
            switch typeV {
            case .one:
                viewOne
            case .two:
                viewTwo
            case .three:
                viewThree
            }
//        }
        Spacer()
    }
    
    private var viewOne: some View {
        Text("One type view")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("TWOOO")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart")
    }
}
