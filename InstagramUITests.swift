//
//  InstagramUITests.swift
//  InstagramUITests
//
//  Created by Robert Percival on 13/06/2017.
//  Copyright © 2017 Robert Percival. All rights reserved.
//

import XCTest

class InstagramUITests: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
    }
    
    func testExample() {
        app.textFields["Email"].tap()
        app.textFields.element.typeText("test@gmail.com")
        let passwordSecureTextField = XCUIApplication().secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("test")
        app.buttons["Sign Up"].tap()
    app.alerts.scrollViews.otherElements.buttons["OK"].tap()

    }
    
    func testExample2() {
        
        ScreenUI.buttons.lgbtn.tap()
        ScreenUI.login(email: "test@gmail.com", password: "test")
        
    
}
}
