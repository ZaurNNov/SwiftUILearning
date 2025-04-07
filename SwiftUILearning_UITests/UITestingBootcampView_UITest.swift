//
//  UITestingBootcampView_UITest.swift
//  SwiftUILearning_UITests
//
//  Created by Zaur  on 04.04.2025.
//

import XCTest
import SwiftUI
@testable import SwiftUILearning


// Testing structure:
// Given
// When
// Then

// Naming struucture: test_[srtuct]_[ui component]_[expected result]

final class UITestingBootcampView_UITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // app.launchArguments = ["-UITest_startSignIn"]
        // app.launchEnvironment = ["-Environment_UITest_startSignIn": "1"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        //
    }
    
    func test_UITestingBootcampView_signUpButton_shouldNotSign() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: false)
        
        // When
        let navigationBar = app.navigationBars["Signed In Home Screen"]
        
        // Then
        XCTAssertFalse(navigationBar.waitForExistence(timeout: 3))
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSign() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: true)
        
        // When
        let navigationBar = app.navigationBars["Signed In Home Screen"]

        // Then
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 3))
    }
    
    func test_SignedInHomeScreen_showAlertButton_shouldDisplayAlert() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: false)
        
        // Then
        let alert = app.alerts.firstMatch //["Welcome"]
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeScreen_showAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: true)

        // When
        tapAlertButton(shouldDismissAlert: true)

        // Then
        let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 1)
        XCTAssertFalse(alertExists)
    }
    
    func test_SignedInHomeScreen_navigationLinkToDestination_shouldNavigateToDestination() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismiss: false)

        // Then
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeScreen_navigationLinkToDestination_shouldNavigateAndBack() {
        // Given
        signInAndSignOut(shouldTypeOnKeyboard: true)

        // When
        tapNavigationLink(shouldDismiss: true)
        
        // Then
        let navigationLinkToDestButton = app.buttons["NavigationLinkToDestination"]
        XCTAssertTrue(navigationLinkToDestButton.exists)
    }
    
//    func test_SignedInHomeScreen_navigationLinkToDestination_shouldNavigateAndBack2() {
//        // Given
//
//        // When
//        tapNavigationLink(shouldDismiss: true)
//        
//        // Then
//        let navigationLinkToDestButton = app.buttons["NavigationLinkToDestination"]
//        XCTAssertTrue(navigationLinkToDestButton.exists)
//    }
}

// MARK: Functions
extension UITestingBootcampView_UITest {
    
    func signInAndSignOut(shouldTypeOnKeyboard: Bool) {
        let textfield = app.textFields["SignInTextField"]
        XCTAssertTrue(textfield.exists)
        if shouldTypeOnKeyboard {
            textfield.tap()
//            let keyA = app.keys["A"]
//            keyA.tap()
//            let keya = app.keys["a"]
//            keya.tap()
//            keya.tap()
//            keya.tap()
            textfield.typeText("Aaaa")
            let returnButton = app.buttons["Return"]
            returnButton.tap()
        }
        let signInButton = app.buttons["SignUpButton"]
        signInButton.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch //["Welcome"]
            let alertCancelBurtton = alert.buttons["Cancel"]
            // sleep(1)
            let alertCancelBurttonExist = alertCancelBurtton.waitForExistence(timeout: 1)
            XCTAssertTrue(alertCancelBurttonExist)
            alertCancelBurtton.tap()
        }
    }
    
    func tapNavigationLink(shouldDismiss: Bool) {
        
        let navigationBar = app.navigationBars["Signed In Home Screen"]
        XCTAssertTrue(navigationBar.exists)
        
        let navigationLinkToDestButton = app.buttons["NavigationLinkToDestination"]
        navigationLinkToDestButton.tap()
        
        if shouldDismiss {
            let backNavigationButton = app.buttons["Signed In Home Screen"]
            backNavigationButton.tap()
            // jump back to previos view (view 2
        }
    }
    
}
    
//    func test_SignedInHomeScreen_showAlertButton_shouldDisplayAndDismissAlert() {
//        let app = XCUIApplication()
//        app.activate()
//        app/*@START_MENU_TOKEN@*/.textFields["SignInTextField"]/*[[".otherElements",".textFields[\"Add your name...\"]",".textFields[\"SignInTextField\"]",".textFields.firstMatch"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".otherElements.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".otherElements.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        aKey.tap()
//        aKey.tap()
//        aKey.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".otherElements",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["SignUpButton"]/*[[".otherElements",".buttons[\"Sign In\"]",".buttons[\"SignUpButton\"]",".buttons.firstMatch"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Welcome to the signed in home screen!"]/*[[".otherElements.buttons[\"Welcome to the signed in home screen!\"]",".buttons[\"Welcome to the signed in home screen!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.otherElements.matching(identifier: "Horizontal scroll bar, 1 page").element(boundBy: 1).tap()
//        
//    }


