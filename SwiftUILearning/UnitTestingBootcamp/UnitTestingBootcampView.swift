//
//  UnitTestingBootcampView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 03.04.2025.
//

/*
 1. Unit tests
 - test the bussines logic in your app
 
 2. UI tests
 - tests the UI of your App
 
 
 
 */

import SwiftUI

struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: true)
}
