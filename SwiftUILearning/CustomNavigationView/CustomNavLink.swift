//
//  CustomNavLink.swift
//  SwiftUILearning
//
//  Created by Zaur  on 01.04.2025.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }

    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(destination: {
            Text("NavigationLink")
            .navigationTitle("NavigationLink Title")
            .navigationBarBackButtonHidden(false)
        }, label: {
            Text("NavigationLink Label")
        })
    }
}
