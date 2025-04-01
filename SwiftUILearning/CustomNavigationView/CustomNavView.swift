//
//  CustomNavView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

#Preview {
    CustomNavView {
        Color.orange.opacity(0.4).ignoresSafeArea()
    }
}
