//
//  SwiftUILearningApp.swift
//  SwiftUILearning
//
//  Created by Zaur  on 14.03.2025.
//

import SwiftUI

@main
struct SwiftUILearningApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        
//        var userIsSignIn: Bool = false
//        // chek arguments
//        if CommandLine.arguments.contains("-UITest_startSignIn") {
//            userIsSignIn = true
//        }
        
        // let userIsSignIn: Bool = CommandLine.arguments.contains("-UITest_startSignIn") ? true : false
        // some as here!
        let userIsSignIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignIn") ? true : false
        
        // as Environment dictionary [String: String]: "-Environment_UITest_startSignIn": "1"
        let userIsSignInStringValue: String = ProcessInfo.processInfo.environment["-Environment_UITest_startSignIn"] ?? ""
        let userIsSignInBoolValue: Bool = userIsSignInStringValue == "1" ? true : false
        
        print("userIsSignIn: \(userIsSignIn)")
        print("userIsSignInBoolValue: \(userIsSignInBoolValue)")
        currentUserIsSignedIn = userIsSignIn
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(viewModel: UITestingBootcampViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
        }
    }
}
