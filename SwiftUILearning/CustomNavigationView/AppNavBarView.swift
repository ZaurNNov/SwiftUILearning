//
//  AppNavView.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        // defaultNavView
//        CustomNavBarContainerView {
//            ZStack {
//                Color.orange.ignoresSafeArea()
//                
//                NavigationLink {
//                    Text("Destination")
//                } label: {
//                    Text("Nav link here")
//                }
//
//            }
//        }
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()

                CustomNavLink {
                    Text("Destination = second screen view")
                    .customNavSubTitle("desctination subtile )")
                    .customNavTitle("second sreen title")
                    .customNavBuckButtonHidden(false)
                } label: {
                    Text("Nav link here")
                }

            }
//            .customNavTitle("custom preference key title")
//            .customNavBuckButtonHidden(true)
//            .customNavSubTitle("i subtile")
            .customNavbarItems(title: "custom preference key title", subtitle: "i subtile", backButtonHidden: true)
        }
        
    }
}

extension AppNavBarView {
    
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.red.opacity(0.3).ignoresSafeArea()
                CustomNavLink {
                    Text("Destination")
                } label: {
                    Text("Destination Label")
                }
                
                
//                NavigationLink {
//                    Text("NavigationLink")
//                    .navigationTitle("NavigationLink Title")
//                    .navigationBarBackButtonHidden(false)
//                } label: {
//                    Text("NavigationLink Label")
//                }
            }
            .navigationTitle("navigationTitle")
        }
    }
}

#Preview {
    AppNavBarView()
}
