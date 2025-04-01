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
    case home, music, profile, settings
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .music:
            return "music.note"
        case .profile:
            return "person"
        case .settings:
            return "gear"
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
        case .settings:
            return "Settings"
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
        case .settings:
            return .cyan
        }
    }
}

//let tabs: [TabBarItem] = [
//    .init(iconName: "house", title: "Home", color: .red),
//    .init(iconName: "music.note", title: "Music", color: .purple),
//    .init(iconName: "person", title: "Profile", color: .green),
//]
