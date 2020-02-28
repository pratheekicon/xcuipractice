//
//  loginscreen.swift
//  InstagramUITests
//
//  Created by Gopinadh Cherupally on 2/23/20.
//  Copyright © 2020 Robert Percival. All rights reserved.
//

import Foundation
import XCTest

class loginScreen {
    static let app = XCUIApplication()
    struct Labels {

//        let welcomeLbl = XCUIApplication().staticTexts["Welcome To Instagram!"]
//        let empwdLbl = XCUIApplication().staticTexts["Enter your email and password below:"]
//        let accountLbl = XCUIApplication().staticTexts["Already have an account?"]
        let emlLbl: XCUIElement
        let pwdLbl: XCUIElement
    }
    
    struct TextFields {
//        let emailTxt = XCUIApplication().textFields["email"]
//        let passTxt = XCUIApplication().textFields["password"]
        let email: XCUIElement
        let password: XCUIElement
    }
    
    struct Buttons {
//        let loginBtn = XCUIApplication().buttons["Log In"]
//        let signUpBtn = XCUIApplication().buttons["Sign Up"]
        let lgbtn: XCUIElement
        let psbtn: XCUIElement
        
    }

    static let textfields = TextFields(email: app.textFields["Email"], password: app.secureTextFields["Password"])
    
    static let buttons = Buttons(lgbtn: app.buttons["Log In"], psbtn: app.buttons["Sign Up"])
    
    static let labels = Labels(emlLbl: app.staticTexts["Enter your email and password below:"], pwdLbl: app.staticTexts["Already, have an account?"])
    
    static func login(email: String, password: String){
        textfields.email.tap()
        textfields.email.typeText(email)
        textfields.password.tap()
        textfields.password.typeText(password)
        buttons.lgbtn.tap()
        
    }
}
