//
//  TabBarItem.swift
//  SwiftUILearning
//
//  Created by Zaur  on 31.03.2025.
//

import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, music, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .music:
            return "music.note"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .music:
            return "Music"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .red
        case .music:
            return .purple
        case .profile:
            return .green
        }
    }
}

//let tabs: [TabBarItem] = [
//    .init(iconName: "house", title: "Home", color: .red),
//    .init(iconName: "music.note", title: "Music", color: .purple),
//    .init(iconName: "person", title: "Profile", color: .green),
//]
