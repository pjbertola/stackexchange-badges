//
//  StackExchangeBadgesUITests.swift
//  StackExchangeBadgesUITests
//
//  Created by Pablo Javier Bertola on 10/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import XCTest

class StackExchangeBadgesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    func testLogin() throws  {
        
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        let textField = webViewsQuery.otherElements["Log In - Stack Overflow"].children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.swipeUp()
        webViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Create Account"]/*[[".otherElements[\"Log into Facebook | Facebook\"]",".otherElements[\"main\"]",".links[\"Create Account\"].staticTexts[\"Create Account\"]",".staticTexts[\"Create Account\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        webViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Log into your Facebook account to connect to Stack Exchange"]/*[[".otherElements[\"Log into Facebook | Facebook\"]",".otherElements[\"main\"].staticTexts[\"Log into your Facebook account to connect to Stack Exchange\"]",".staticTexts[\"Log into your Facebook account to connect to Stack Exchange\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        

        
    }
    
    func testLogin2() throws  {
        
        //Complete with user, password and userName
        let loginUser = ""
        let loginPass = ""
        let userName = "Pablo.J."
        
        //Launch app
        let app = XCUIApplication()
        app.launch()
        
        //Webview
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        let logInStackOverflowElement = webViewsQuery.otherElements["Log In - Stack Overflow"]
        let nameTextField = logInStackOverflowElement.children(matching: .textField).element
        
        //Wait to de site to load
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: nameTextField, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Complete user name
        nameTextField.tap()
        nameTextField.typeText(loginUser)
        let logInButton = webViewsQuery.buttons["Log in"]
        
        //Complete secure name
        let secureTextField = logInStackOverflowElement.children(matching: .secureTextField).element
        XCTAssertTrue(secureTextField.exists)
        secureTextField.tap()
        secureTextField.typeText(loginPass)
        
        //Login
        logInButton.tap()
        
        //check if name is correct.
        let nameLb = app.staticTexts[userName]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: nameLb, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}
