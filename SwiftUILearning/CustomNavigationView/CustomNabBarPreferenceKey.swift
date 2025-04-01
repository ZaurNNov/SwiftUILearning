//
//  CustomNabBarPreferenceKey.swift
//  SwiftUILearning
//
//  Created by Zaur  on 01.04.2025.
//

import SwiftUI

//@Environment(\.presentationMode) var presentationMode
//@State private var showBackButton: Bool = true
//@State private var title: String = "Title" // ""
//@State private var subtitle: String? = "Subtitle"

struct CustomNabBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNabBarSubTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNabBarBackButtonHidenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    
    //                    .navigationTitle("NavigationLink Title")
    //                    .navigationBarBackButtonHidden(false)
    
    func customNavTitle(_ title: String) -> some View {
        preference(key: CustomNabBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavSubTitle(_ subtitle: String?) -> some View {
        preference(key: CustomNabBarSubTitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavBuckButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNabBarBackButtonHidenPreferenceKey.self, value: hidden)
    }
    
    func customNavbarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavTitle(title)
            .customNavSubTitle(subtitle)
            .customNavBuckButtonHidden(backButtonHidden)
    }
}
