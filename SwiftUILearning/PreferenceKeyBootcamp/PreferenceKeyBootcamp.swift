//
//  PreferenceKeyBootcamp.swift
//  SwiftUILearning
//
//  Created by Заур Гиясов on 27.03.2025.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text = "some text in variable"
    
    var body: some View {
        NavigationView {
            VStack {
//                Text(text)
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    //.preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
                    // .customTitle("NEW Custom Value")
                    
            }
            
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
        
        Text("Hello, World!")
        
    }
}

extension View {
    
    func customTitle(_ text: String) -> some View {
        self.preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct SecondaryScreen: View {
    
    let text: String
    @State private var newvalue: String = ""
    
    var body: some View {
        Text(text)
//            .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            .onAppear(perform: getData)
            .customTitle(newvalue)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.newvalue = "data from pending"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    PreferenceKeyBootcamp()
}
